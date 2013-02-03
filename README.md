# Gem Mirror

Gem-mirror is a Ruby application that makes it easy to create your own RubyGems
mirror without having to stitch together ugly Bash scripts or deal with more
complex tools such as [Geminabox][geminabox]. Unlike tools such as Geminabox
and other gem-mirror does mirroring only, it has no authentication and you
can't upload Gems to it.

## Differences with Geminabox

Geminabox is basically a tiny DIY RubyGems that focuses more on uploading your
own Gems (e.g. company specific ones) instead of mirroring an external source.
Gem-mirror however purely focuses on generating a mirror that can be used by
the RubyGems CLI utility.

## Differences with gem-server

RubyGems comes with the command `gem-server` which can be used to serve the
Gems you have installed on that machine and user. Similar to Geminabox it does
not provide the means to actually mirror an external source. It's also Rack
based and uses WEBRick, which isn't exactly the best server around.

## How do I use it?

The process of setting up a mirror is fairly easy and can be done in a matter
of minutes depending on the amount of Gems you're mirroring and your internet
speed.

The first step is to set up a new, empty mirror. This is done by running the
`gem-mirror init` command similar to how you initialize a new Git repository:

    $ gem-mirror init /srv/http/mirror.com/

Once created you should edit the main configuration file called `config.rb`.
This configuration file specifies what sources to mirror (you can mirror
multiple ones!), which Gems, etc.

Once configured you can pull all the Gems by running the following command:

    $ gem-mirror update

If your configuration file is not located in the current directory you can
specify the path to it using the `-c` or `--config` option. The process of
downloading all the Gems takes a while and can use quite a bit of memory so
make sure you have plenty of time and RAM available.

Once all the Gems have been downloaded you'll need to generate an index of all
the installed files. This can be done as following:

    $ gem-mirror index

Last but not least you'll want to generate a list of SHA512 checksums. Although
RubyGems doesn't use these they might come in handy when verifying Gems (e.g.
when RubyGems gets hacked again). This can be done using the following command:

    $ gem-mirror checksum

If you want to do all this automatically (which is recommended) you can use a
simple Cronjob like the following one:

    @hourly cd /srv/http/mirror.com && gem-mirror update && gem-mirror index

## Requirements

* Ruby 1.9.2 or newer
* Enough space to store Gems

## Installation

Assuming RubyGems isn't down you can install the Gem as following:

    $ gem install gem-mirror

## License

All source code in this repository is licensed under the MIT license unless
specified otherwise. A copy of this license can be found in the file "LICENSE"
in the root directory of this repository.

[geminabox]: https://github.com/cwninja/geminabox
