require 'rubygems'
require 'rake'
require "bundler/gem_tasks"

desc "Check if blinky is working with your USB device"
task :check_device do
  require 'manual_tests/device_checker'
  DeviceChecker.new.check
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec
