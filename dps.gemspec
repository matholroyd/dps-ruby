Gem::Specification.new do |s|
  s.name        = 'dps'
  s.version     = '0.0.0'
  s.date        = '2019-01-22'
  s.summary     = "DPS is a collection of tools to help interact with or implement a DPS server"
  s.description = "Direct Payment Standard (DPS) specifies a common way for entities to advertise payment options as well as facilitate payments directly between 2 parties. This library contains tools to interact with or implement a DPS server."
  s.authors     = ["Mat Holroyd"]
  s.email       = 'dps@matholroyd.com'
  s.files       = %w{
    lib/dps.rb
    lib/dps/dns.rb
  }
  s.homepage    = 'https://github.com/matholroyd/dps-ruby'
  s.license     = 'MIT'
end