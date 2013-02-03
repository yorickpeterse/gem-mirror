module GemMirror
  ##
  # The Gem class contains data about a Gem such as the name, requirement as
  # well as providing some methods to more easily extract the specific version
  # number.
  #
  # @!attribute [r] name
  #  @return [String]
  # @!attribute [r] requirement
  #  @return [Gem::Requirement]
  #
  class Gem
    attr_reader :name, :requirement

    ##
    # Returns a `Gem::Version` instance based on the specified requirement.
    #
    # @param [Gem::Requirement] requirement
    # @return [Gem::Version]
    #
    def self.version_for(requirement)
      return ::Gem::Version.new(requirement.requirements.sort.last.last.version)
    end

    ##
    # @param [String] name
    # @param [Gem::Requirement] requirement
    #
    def initialize(name, requirement = nil)
      requirement ||= ::Gem::Requirement.default

      if requirement.is_a?(String)
        requirement = ::Gem::Requirement.new(requirement)
      end

      @name        = name
      @requirement = requirement
    end

    ##
    # @return [Gem::Version]
    #
    def version
      return @version ||= self.class.version_for(requirement)
    end

    ##
    # @return [TrueClass|FalseClass]
    #
    def has_version?
      return version && !version.segments.reject { |s| s == 0 }.empty?
    end

    ##
    # Returns the filename of the Gemfile.
    #
    # @param [String] gem_version
    # @return [String]
    #
    def filename(gem_version = nil)
      gem_version ||= version.to_s

      return "#{name}-#{gem_version}.gem"
    end
  end # Gem
end # GemMirror
