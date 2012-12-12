module Blinky
  class LightFactory

    def self.detect_lights plugins, recipes
      lights = []
      found_devices = [] 
      USB.devices.each do |device| 
        found_devices << device  
        matching_recipe = recipes[device.idVendor][device.idProduct] 
        if matching_recipe
          lights << Light.new(device.open, matching_recipe, plugins)
        end
      end
      raise NoSupportedDevicesFound.new found_devices if lights.empty?
      lights
    end

  end
end