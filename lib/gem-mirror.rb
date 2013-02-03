require 'rubygems'
require 'rubygems/user_interaction'
require 'rubygems/indexer'
require 'slop'
require 'fileutils'
require 'digest/sha2'
require 'confstruct'
require 'zlib'
require 'httpclient'
require 'logger'
require 'stringio'

unless $:.include?(File.expand_path('../', __FILE__))
  $:.unshift(File.expand_path('../', __FILE__))
end

require 'gem-mirror/version'
require 'gem-mirror/configuration'
require 'gem-mirror/gem'
require 'gem-mirror/source'
require 'gem-mirror/mirror_directory'
require 'gem-mirror/mirror_file'
require 'gem-mirror/versions_file'
require 'gem-mirror/versions_fetcher'
require 'gem-mirror/gems_fetcher'

require 'gem-mirror/cli'
require 'gem-mirror/cli/init'
require 'gem-mirror/cli/update'
require 'gem-mirror/cli/index'
require 'gem-mirror/cli/checksum'
