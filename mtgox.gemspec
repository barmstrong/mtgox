Kernel.load File.expand_path("../lib/mtgox/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name        = "mtgox"
  s.version     = MtGox::VERSION
  s.summary     = %q{An Improved version of mtgox-gem with HTTP API v1}
  s.description = %q{An Improved version of mtgox-gem with HTTP API v1}
  s.author      = "Guten"
  s.email       = "ywzhaifei@gmail.com"
  s.homepage    = "https://github.com/GutenYe/mtgox"
  s.required_ruby_version = ">= 1.9.2"
  s.files       = `git ls-files`.split("\n")

  s.add_dependency "pd"
  s.add_dependency "tagen"
  s.add_dependency "faraday", "~> 0.7"
  s.add_dependency "faraday_middleware", "~> 0.8"
  s.add_dependency "multi_json", "~> 1.0"
end
