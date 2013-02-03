module GemMirror
  ##
  # Similar to {GemMirror::MirrorDirectory} the MirrorFile class is used to
  # make it easier to read and write data in a directory that mirrors data from
  # an external source.
  #
  # @!attribute [r] path
  #  @return [String]
  #
  class MirrorFile
    attr_reader :path

    ##
    # @param [String] path
    #
    def initialize(path)
      @path = path
    end

    ##
    # Writes the specified content to the current file. Existing files are
    # overwritten.
    #
    # @param [String] content
    #
    def write(content)
      handle = File.open(path, 'w')

      handle.write(content)
      handle.close
    end

    ##
    # Reads the content of the current file.
    #
    # @return [String]
    #
    def read
      handle  = File.open(path, 'r')
      content = handle.read

      handle.close

      return content
    end

    ##
    # Reads the contents of a Gzip encoded file.
    #
    # @return [String]
    #
    def read_gzip
      content = nil

      Zlib::GzipReader.open(path) do |gz|
        content = gz.read
        gz.close
      end

      return content
    end
  end # MirrorFile
end # GemMirror
