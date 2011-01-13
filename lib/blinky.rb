$:.unshift(File.dirname(__FILE__))

require 'usb'
require 'blinky/no_supported_devices_found'

module Blinky
  class Blinky
    
    def device
      @device
    end
    
    def initialize(path = File.dirname(__FILE__)) 
   
      Dir["#{path}/device_recipes/**/*.rb"].each { |f| require(f) }
      Dir["#{path}/ci_server_plugins/**/*.rb"].each { |f| require(f) }
      @recipes = Hash.new(:default => {})
      @plugins = []
      instance_eval(File.read("#{path}/recipes.rb"))
      instance_eval(File.read("#{path}/plugins.rb"))
      
      @plugins.each do |plugin|
        self.extend(plugin)
      end
      found_devices = []  
            
      USB.devices.each do |device| 
        found_devices << device  
        matching_recipe = @recipes[device.idVendor][device.idProduct] 
        if matching_recipe
           self.extend(matching_recipe)
           @device = device
           @handle = device.usb_open
        end
      end
      
      raise NoSupportedDevicesFound.new found_devices unless @handle
    end

    def recipe recipe_module, details
       if @recipes[details[:usb_vendor_id]].empty?
          @recipes[details[:usb_vendor_id]] = {details[:usb_product_id] => recipe_module}
       else
          @recipes[details[:usb_vendor_id]][details[:usb_product_id]] = recipe_module
       end
        
    end
    
    def plugin plugin_module
      @plugins << plugin_module
    end
        
  end
    
end