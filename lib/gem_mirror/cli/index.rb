# frozen_string_literal: true

GemMirror::CLI.options.command "index" do
  banner      "Usage: gem_mirror index [OPTIONS]"
  description "Indexes a list of Gems"
  separator   "\nOptions:\n"

  on :h, :help, "Shows this help message" do
    puts self
    exit
  end

  on :c=, :config=, "Path to the configuration file"

  run do |opts, _args|
    GemMirror::CLI.load_configuration(opts[:c])

    config = GemMirror.configuration

    unless File.directory?(config.destination)
      config.logger.error("The directory #{config.destination} does not exist")
      abort
    end

    indexer = Gem::Indexer.new(config.destination, build_legacy: opts[:l])

    config.logger.info("Generating Indexes")

    indexer.generate_index
  end
end
