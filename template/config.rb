# frozen_string_literal: true

# This is the main configuration file for your RubyGems mirror. Here you can
# change settings such as the location to store Gem files in and what sources
# and Gems you'd like to mirror.
GemMirror.configuration.configure do
  # The directory to store indexing information as well as the Gem files in.
  destination File.expand_path("public", __dir__)

  # Directory to use for storing SHA512 checksums of each Gem.
  checksums File.expand_path("public/checksums", __dir__)

  # When set to `true` development dependencies of Gems will also be mirrored.
  development false

  # If you're mirroring a lot of Gems you'll probably want to switch the
  # logging level to Logger::ERROR or Logger::INFO to reduce the amount of
  # noise.
  logger.level = Logger::DEBUG

  # A source is a remote location that you want to mirror. The first parameter
  # of this method is the human readable name, the second one the URL. The
  # supplied block is used to determine what Gems (and versions) to mirror.
  source "rubygems", "https://rubygems.org" do
    gem "rack", ">= 1.0.0"
  end
end
