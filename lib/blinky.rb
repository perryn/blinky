$:.unshift(File.dirname(__FILE__))

require 'usb'
require 'blinky/no_supported_devices_found'

module Blinky
  class Indicator
    
    def initialize(path = File.join(File.dirname(__FILE__), '..', 'device_recipes')) 
      @recipes = Hash.new(:default => {})
      Dir["#{path}/*/*.rb"].each { |f| require(f) }
      instance_eval(File.read("#{path}/recipes.rb"))
      found_devices = []
      USB.devices.each do |device|
        found_devices << device  
        matching_recipe = @recipes[device.idVendor][device.idProduct]   
        if matching_recipe
           self.extend(matching_recipe)
           @supported_device = device
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
    
 

    def add_recipe recipe_module, details
       @recipes[details[:usb_vendor_id]] = {details[:usb_product_id] => recipe_module}
    end
    
  end
end