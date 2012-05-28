# Hn

A tiny gem to fetch Hacker News entries

## Installation

Add this line to your application's Gemfile:

    gem 'hn'

And then execute:

    $ bundle

## Usage

    require 'hn'

    # return 30 homepage entries
    HackerNews::Engine.homepage

    # return 30 newest entries
    HackerNews::Engine.newest

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
