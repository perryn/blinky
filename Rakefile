require 'rubygems'
require 'rake'

desc "Check if blinky is working with your USB device"
task :check_device do
  require 'manual_tests/device_checker'
  DeviceChecker.new.check
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "blinky"
    gem.summary = %Q{helps you see the light}
    gem.description = %Q{plug and play support for USB build status indicators}
    gem.email = "perryn.fowler@gmail.com"
    gem.homepage = "http://github.com/perryn/blinky"
    gem.authors = ["Perryn Fowler"]
    gem.add_dependency "ruby-usb"
    gem.add_development_dependency "rspec", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'

Spec::Rake::SpecTask.new do |t|
  t.warning = true
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "blinky #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
