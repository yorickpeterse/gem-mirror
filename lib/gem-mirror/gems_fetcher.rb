module GemMirror
  ##
  # The GemsFetcher class is responsible for downloading Gems from an external
  # source as well as downloading all the associated dependencies.
  #
  # @!attribute [r] source
  #  @return [Source]
  # @!attribute [r] versions_file
  #  @return [GemMirror::VersionsFile]
  #
  class GemsFetcher
    attr_reader :source, :versions_file

    ##
    # @param [Source] source
    # @param [GemMirror::VersionsFile] versions_file
    #
    def initialize(source, versions_file)
      @source        = source
      @versions_file = versions_file
    end

    ##
    # Fetches the Gems and all associated dependencies.
    #
    def fetch
      source.gems.each do |gem|
        versions_for(gem).each do |version|
          filename  = gem.filename(version)
          satisfied = gem.requirement.satisfied_by?(version)
          name      = gem.name

          if gem_exists?(filename) or ignore_gem?(name, version) or !satisfied
            logger.debug("Skipping #{filename}")
            next
          end

          # Prevent circular dependencies from messing things up.
          configuration.ignore_gem(gem.name, version)

          spec = fetch_specification(gem, version)

          next unless spec

          spec = load_specification(spec)
          deps = dependencies_for(spec)

          unless deps.empty?
            logger.info("Fetching dependencies for #{filename}")

            fetch_dependencies(deps)
          end

          logger.info("Fetching #{filename}")

          gemfile = fetch_gem(gem, version)

          if gemfile
            configuration.mirror_directory.add_file(filename, gemfile)
          end
        end
      end
    end

    ##
    # Returns an Array containing the versions that should be fetched for a
    # Gem.
    #
    # @param [GemMirror::Gem] gem
    # @return [Array]
    #
    def versions_for(gem)
      available       = versions_file.versions_for(gem.name)
      versions        = gem.has_version? ? [gem.version] : available
      available_names = available.map(&:to_s)

      # Get rid of invalid versions. Due to Gem::Version having a custom ==
      # method, which treats "3.4" the same as "3.4.0" we'll have to compare
      # the versions as String instances.
      versions = versions.select do |version|
        available_names.include?(version.to_s)
      end

      versions = [available.last] if versions.empty?

      return versions
    end

    ##
    # Tries to download the specification for a Gem and version. This method
    # returns the raw inflated data instead of an instance of
    # `Gem::Specification`.
    #
    # @param [GemMirror::Gem] gem
    # @param [Gem::Version] version
    # @return [String]
    #
    def fetch_specification(gem, version)
      specification = nil
      filename      = gem.filename(version)

      begin
        specification = source.fetch_specification(gem.name, version)
      rescue => e
        logger.error("Failed to retrieve #{filename}: #{e.message}")
        logger.debug("Adding #{filename} to the list of ignored Gems")

        configuration.ignore_gem(gem.name, version)
      end

      return specification
    end

    ##
    # Tries to download the Gemfile for the specified Gem and version.
    #
    # @param [GemMirror::Gem] gem
    # @param [Gem::Version] version
    # @return [String]
    #
    def fetch_gem(gem, version)
      gemfile  = nil
      filename = gem.filename(version)

      begin
        gemfile = source.fetch_gem(gem.name, version)
      rescue => e
        logger.error("Failed to retrieve #{filename}: #{e.message}")
        logger.debug("Adding #{filename} to the list of ignored Gems")

        configuration.ignore_gem(gem.name, version)
      end

      return gemfile
    end

    ##
    # Reads the inflated data of a Gemspec and returns the loaded specification
    # instance.
    #
    # @param [String] raw_spec
    # @return [Gem::Specification]
    #
    def load_specification(raw_spec)
      stream  = Zlib::Inflate.new
      content = stream.inflate(raw_spec)

      stream.finish
      stream.close

      return Marshal.load(content)
    end

    ##
    # Fetches the Gem files for the specified dependencies.
    #
    # @param [Array] deps
    #
    def fetch_dependencies(deps)
      self.class.new(source.updated(deps), versions_file).fetch
    end

    ##
    # Returns an Array containing all the dependencies of a given Gem
    # specification.
    #
    # @param [Gem::Specification] spec
    # @return [Array]
    #
    def dependencies_for(spec)
      possible_dependencies = configuration.development ? spec.dependencies \
        : spec.runtime_dependencies

      dependencies = filter_dependencies(possible_dependencies)

      return assign_gem_versions(dependencies)
    end

    ##
    # Filters a list of dependencies based on whether or not they are ignored.
    #
    # @param [Array] possible_dependencies
    # @return [Array]
    #
    def filter_dependencies(possible_dependencies)
      dependencies = []

      possible_dependencies.each do |dependency|
        gem = Gem.new(dependency.name, dependency.requirement)

        unless ignore_gem?(gem.name, gem.version)
          dependencies << gem
        end
      end

      return dependencies
    end

    ##
    # Processes a list of Gems and sets their versions to the latest one
    # available in case no specific version is given.
    #
    # @param [Array] gems
    # @return [Array]
    #
    def assign_gem_versions(gems)
      gems = gems.map do |gem|
        unless gem.has_version?
          latest = versions_file.versions_for(gem.name).last
          gem    = Gem.new(gem.name, latest.to_s) if latest
        end

        gem
      end

      return gems
    end

    ##
    # @see GemMirror::Configuration#logger
    # @return [Logger]
    #
    def logger
      return configuration.logger
    end

    ##
    # @see GemMirror.configuration
    #
    def configuration
      return GemMirror.configuration
    end

    ##
    # Checks if a given Gem has already been downloaded.
    #
    # @param [String] filename
    # @return [TrueClass|FalseClass]
    #
    def gem_exists?(filename)
      return configuration.mirror_directory.file_exists?(filename)
    end

    ##
    # @see GemMirror::Configuration#ignore_gem?
    #
    def ignore_gem?(*args)
      return configuration.ignore_gem?(*args)
    end
  end # GemsFetcher
end # GemMirror
