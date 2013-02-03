GemMirror::CLI.options.command 'init' do
  banner      'Usage: gem-mirror init [DIRECTORY] [OPTIONS]'
  description 'Sets up a new mirror'
  separator   "\nOptions:\n"

  on :h, :help, 'Shows this help message' do
    puts self
    exit
  end

  run do |opts, args|
    directory = File.expand_path(args[0] || Dir.pwd)
    template  = GemMirror::Configuration.template_directory

    Dir.mkdir(directory) unless File.directory?(directory)

    FileUtils.cp_r(File.join(template, '.'), directory)

    puts "Initialized empty mirror in #{directory}"
  end
end
