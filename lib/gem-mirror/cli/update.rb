GemMirror::CLI.options.command 'update' do
  banner      'Usage: gem-mirror update [OPTIONS]'
  description 'Updates the list of Gems'
  separator   "\nOptions:\n"

  on :h, :help, 'Shows this help message' do
    puts self
    exit
  end

  on :c=, :config=, 'Path to the configuration file'

  run do |opts, args|
    GemMirror::CLI.load_configuration(opts[:c])

    GemMirror.configuration.sources.each do |source|
      versions = GemMirror::VersionsFetcher.new(source).fetch
      gems     = GemMirror::GemsFetcher.new(source, versions)

      gems.fetch
    end
  end
end
