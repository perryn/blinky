$:.unshift(File.dirname(__FILE__))

require 'usb'
require 'blinky/no_supported_devices_found'

module Blinky
  class Indicator
    
    def initialize(path = "#{File.dirname(__FILE__)}/../device_recipes/**/*.rb")
      Dir[path].each { |f| require(f) }
      found_devices = []
      USB.devices.each do |device|
        found_devices << device
        begin
           device_module_name =  "Blinky::Vendor_%04x::Product_%04x" % [device.idVendor, device.idProduct]
           self.extend(eval(device_module_name))
           @supported_device = device
        rescue NameError
        end
      end
      raise NoSupportedDevicesFound.new(found_devices) unless @supported_device
      @handle = @supported_device.usb_open
    end
    
    def success!
      begin
       show_success(@handle) 
      rescue  Errno::EPIPE
      end
    end
    
    def failure!
      begin
       show_failure(@handle) 
      rescue  Errno::EPIPE
      end
    end
    
    def building!
      begin
       show_building(@handle) 
      rescue  Errno::EPIPE
      end
    end
    
    
  end
end