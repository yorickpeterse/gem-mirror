# This is the main configuration file for your RubyGems mirror. Here you can
# change settings such as the location to store Gem files in, what Gems to
# ignore, what sources to mirror and so on.
GemMirror.configuration.configure do
  # The directory to store indexing information as well as the Gem files in.
  destination File.expand_path('../public', __FILE__)

  # Directory to use for storing SHA512 checksums of each Gem.
  checksums File.expand_path('../public/checksums', __FILE__)

  # When set to `true` development dependencies of Gems will also be mirrored.
  development false

  # By default everything is logged.
  # logger.level = Logger::ERROR

  # A source is a remote location that you want to mirror. The first parameter
  # of this method is the human readable name, the second one the URL. The
  # supplied block is used to determine what Gems (and versions) to mirror.
  source 'rubygems', 'http://rubygems.org' do
    gem 'rack', '>= 1.0.0'
  end
end
