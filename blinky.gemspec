# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blinky/version'

Gem::Specification.new do |gem|
  gem.name          = "blinky"
  gem.version       = Blinky::VERSION
  gem.authors       = ["Perryn Fowler"]
  gem.email         = ["perryn.fowler@gmail.com"]
  gem.description   = %q{plug and play support for USB build status indicators}
  gem.homepage      = "http://github.com/perryn/blinky"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency "ruby-usb", ">= 0.2.1"
  
  gem.add_development_dependency "rspec", "~> 2.11.0"
  gem.add_development_dependency "rake"
end
