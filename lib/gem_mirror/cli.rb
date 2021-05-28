# frozen_string_literal: true

module GemMirror
  # Namespace for classes and modules that handle the command line interface
  module CLI
    ##
    # Hash containing the default Slop options.
    #
    # @return [Hash]
    #
    SLOP_OPTIONS = {
      strict: true,
      banner: "Usage: gem_mirror [COMMAND] [OPTIONS]"
    }.freeze

    ##
    # @return [Slop]
    #
    def self.options
      @options ||= default_options
    end

    ##
    # Loads the specified configuration file or displays an error if it doesn't
    # exist.
    #
    # @param [String] config_file
    # @return [GemMirror::Configuration]
    #
    def self.load_configuration(config_file)
      config_file ||= Configuration.default_configuration_file
      config_file   = File.expand_path(config_file, Dir.pwd)

      abort "The configuration file #{config_file} does not exist" unless File.file?(config_file)

      require(config_file)
    end

    ##
    # @return [Slop]
    #
    def self.default_options
      Slop.new(SLOP_OPTIONS.dup) do
        separator "\nOptions:\n"

        on :h, :help, "Shows this help message" do
          puts self
          exit
        end

        on :v, :version, "Shows the current version" do
          puts CLI.version_information
        end
      end
    end

    ##
    # Returns a String containing some platform/version related information.
    #
    # @return [String]
    #
    def self.version_information
      "gem_mirror v#{VERSION} on #{RUBY_DESCRIPTION}"
    end
  end
end
