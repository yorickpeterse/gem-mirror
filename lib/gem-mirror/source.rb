module GemMirror
  ##
  # The Source class is used for storing information about an external source
  # such as the name and the Gems to mirror.
  #
  # @!attribute [r] name
  #  @return [String]
  # @!attribute [r] host
  #  @return [String]
  # @!attribute [r] gems
  #  @return [Array]
  #
  class Source
    attr_reader :name, :host, :gems

    ##
    # @param [String] name
    # @param [String] host
    # @param [Array] gems
    #
    def initialize(name, host, gems = [])
      @name = name.downcase.gsub(/\s+/, '_')
      @host = host.chomp('/')
      @gems = gems
    end

    ##
    # Returns a new Source instance based on the current one.
    #
    # @param [Array] new_gems The gems to set, overwrites the current ones.
    # @return [Source]
    #
    def updated(new_gems)
      return self.class.new(name, host, new_gems)
    end

    ##
    # Fetches a list of all the available Gems and their versions.
    #
    # @return [String]
    #
    def fetch_versions
      return http_get(host + '/' + Configuration.versions_file).body
    end

    ##
    # Fetches the Gem specification of a Gem.
    #
    # @param [String] name
    # @param [String] version
    # @return [String]
    #
    def fetch_specification(name, version)
      url = host + "/quick/#{Configuration.marshal_identifier}" +
        "/#{name}-#{version}.gemspec.rz"

      return http_get(url).body
    end

    ##
    # Fetches the `.gem` file of a given Gem and version.
    #
    # @param [String] name
    # @param [String] version
    # @return [String]
    #
    def fetch_gem(name, version)
      return http_get(host + "/gems/#{name}-#{version}.gem").body
    end

    ##
    # Adds a new Gem to the source.
    #
    # @param [String] name
    # @param [String] requirement
    #
    def gem(name, requirement = nil)
      gems << Gem.new(name, ::Gem::Requirement.new(requirement))
    end

    private

    ##
    # Requests the given HTTP resource.
    #
    # @param [String] url
    # @return [HTTP::Message]
    #
    def http_get(url)
      response = client.get(url, :follow_redirect => true)

      unless HTTP::Status.successful?(response.status)
        raise HTTPClient::BadResponseError, response.reason
      end

      return response
    end

    ##
    # @return [HTTPClient]
    #
    def client
      return @client ||= HTTPClient.new
    end
  end # Source
end # GemMirror
