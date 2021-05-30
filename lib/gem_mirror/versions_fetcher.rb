# frozen_string_literal: true

module GemMirror
  ##
  # The VersionsFetcher class is used for retrieving the file that contains all
  # registered Gems and their versions.
  #
  # @!attribute [r] source
  #  @return [Source]
  #
  class VersionsFetcher
    attr_reader :source

    ##
    # @param [Source] source
    #
    def initialize(source)
      @source = source
    end

    ##
    # @return [GemMirror::VersionsFile]
    #
    def fetch
      GemMirror.configuration.logger.info(
        "Updating #{source.name} (#{source.host})"
      )

      VersionsFile.load(source.fetch_versions)
    end
  end
end
