GemMirror::CLI.options.command 'checksum' do
  banner      'Usage: gem-mirror checksum [OPTIONS]'
  description 'Generates SHA512 checksums of all gems'
  separator   "\nOptions:\n"

  on :h, :help, 'Shows this help message' do
    puts self
    exit
  end

  on :c=, :config=, 'Path to the configuration file'

  run do |opts, args|
    GemMirror::CLI.load_configuration(opts[:c])

    config = GemMirror.configuration

    unless File.directory?(config.checksums)
      config.logger("The directory #{config.checksums} does not exist")
      abort
    end

    unless File.directory?(config.destination)
      config.logger("The directory #{config.destination} does not exist")
      abort
    end

    Dir[File.join(config.gems_directory, '*.gem')].each do |gem|
      basename = File.basename(gem)
      name     = basename + '.sha512'

      config.logger.info("Creating checksum for #{basename}")

      hash   = Digest::SHA512.hexdigest(File.read(gem))
      handle = File.open(File.join(config.checksums, name), 'w')

      handle.write(hash)
      handle.close
    end
  end
end
