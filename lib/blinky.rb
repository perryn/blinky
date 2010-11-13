$:.unshift(File.dirname(__FILE__))

require "ribusb"
require 'blinky/no_supported_devices_found'

module Blinky
  class Blinky
    
    def initialize(path = File.join(File.dirname(__FILE__), '..', 'device_recipes')) 
   
      Dir["#{path}/*/*.rb"].each { |f| require(f) }
      @recipes = Hash.new(:default => {})
      instance_eval(File.read("#{path}/recipes.rb"))
      
      found_devices = []        
      RibUSB::Bus.new.find.each do |device|
        found_devices << device  
        matching_recipe = @recipes[device.idVendor][device.idProduct]   
        if matching_recipe
           self.extend(matching_recipe)
           @device = device
        end
      end
      
      raise NoSupportedDevicesFound.new found_devices unless @device
    end

    def recipe recipe_module, details
       @recipes[details[:usb_vendor_id]] = {details[:usb_product_id] => recipe_module}
    end
    
    def close
      @device = nil
    end
    
  end
  
  def self.check_device
    blinky = Blinky.new
    puts "Your Device should now be indicating 'SUCCESS'"
    blinky.success!
    sleep(2)
    puts "Your Device should now be indicating 'FAILURE'"
    blinky.failure!
    sleep(2)
    puts "Your Device should now be indicating 'BUILDING'"
    blinky.building!
    sleep(2)
    puts "CHECK COMPLETE"
    blinky.off!
    blinky.close
  end
  
end