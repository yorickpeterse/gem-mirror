# frozen_string_literal: true

module GemMirror
  ##
  # @return [GemMirror::Configuration]
  #
  def self.configuration
    @configuration ||= Configuration.new
  end

  ##
  # Configuration class used for storing data about a mirror such as the
  # destination directory, sources, ignored Gems, etc.
  #
  class Configuration < Confstruct::Configuration
    ##
    # @return [Logger]
    #
    def logger
      @logger ||= Logger.new($stdout)
    end

    ##
    # @return [String]
    #
    def self.template_directory
      File.expand_path("../../template", __dir__)
    end

    ##
    # @return [String]
    #
    def self.default_configuration_file
      File.expand_path("config.rb", Dir.pwd)
    end

    ##
    # Returns the name of the directory that contains the quick
    # specification files.
    #
    # @return [String]
    #
    def self.marshal_identifier
      "Marshal.#{marshal_version}"
    end

    ##
    # Returns the name of the file that contains an index of all the versions.
    #
    # @return [String]
    #
    def self.versions_file
      "specs.#{marshal_version}.gz"
    end

    ##
    # Returns a String containing the Marshal version.
    #
    # @return [String]
    #
    def self.marshal_version
      "#{Marshal::MAJOR_VERSION}.#{Marshal::MINOR_VERSION}"
    end

    ##
    # @return [GemMirror::MirrorDirectory]
    #
    def mirror_directory
      @mirror_directory ||= MirrorDirectory.new(gems_directory)
    end

    ##
    # @return [String]
    #
    def gems_directory
      File.join(destination, "gems")
    end

    ##
    # Returns a Hash containing various Gems to ignore and their versions.
    #
    # @return [Hash]
    #
    def ignored_gems
      @ignored_gems ||= Hash.new { |hash, key| hash[key] = [] }
    end

    ##
    # Adds a Gem to the list of Gems to ignore.
    #
    # @param [String] name
    # @param [String] version
    #
    def ignore_gem(name, version)
      ignored_gems[name] ||= []
      ignored_gems[name] << version
    end

    ##
    # Checks if a Gem should be ignored.
    #
    # @param [String] name
    # @param [String] version
    # @return [TrueClass|FalseClass]
    #
    def ignore_gem?(name, version)
      ignored_gems[name].include?(version)
    end

    ##
    # Returns a list of sources to mirror.
    #
    # @return [Array]
    #
    def sources
      @sources ||= []
    end

    ##
    # Adds a new source to mirror.
    #
    # @param [String] name
    # @param [String] url
    # @param [Proc] block
    # @yieldparam [GemMirror::Source] source
    #
    def source(name, url, &block)
      source = Source.new(name, url)
      source.instance_eval(&block)

      sources << source
    end
  end
end
