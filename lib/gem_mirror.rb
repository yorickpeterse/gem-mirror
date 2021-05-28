# frozen_string_literal: true

require "rubygems"
require "rubygems/user_interaction"
require "rubygems/indexer"
require "slop"
require "fileutils"
require "digest/sha2"
require "confstruct"
require "zlib"
require "httpclient"
require "logger"
require "stringio"

$LOAD_PATH.unshift(File.expand_path(__dir__)) unless $LOAD_PATH.include?(File.expand_path(__dir__))

require_relative "gem_mirror/version"
require_relative "gem_mirror/configuration"
require_relative "gem_mirror/gem"
require_relative "gem_mirror/source"
require_relative "gem_mirror/mirror_directory"
require_relative "gem_mirror/mirror_file"
require_relative "gem_mirror/versions_file"
require_relative "gem_mirror/versions_fetcher"
require_relative "gem_mirror/gems_fetcher"

require_relative "gem_mirror/cli"
require_relative "gem_mirror/cli/init"
require_relative "gem_mirror/cli/update"
require_relative "gem_mirror/cli/index"
require_relative "gem_mirror/cli/checksum"
