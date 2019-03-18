# DPS Ruby gem

This Ruby library is a collection of tools to help interact with or implement a DPS (Direct Payment Standard) server.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dps'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dps


## Examples

`get_endpoint` returns the DPS endpoint for a domain. E.g.


```ruby
Dps::DNS.get_endpoint('example.com')

# if `tworgy.com` has a DNS TXT record with the value 'dps:endpoint url=https://tworgy.com/dps'

Dps::DNS.get_endpoint('tworgy.com') # returns 'https://tworgy.com/dps'
```

