$:.unshift(File.dirname(__FILE__))

require 'libusb/compat'
require 'blinky/no_supported_devices_found'
require 'blinky/light'
require 'blinky/light_factory'

module Blinky

  def self.new
    Blinky.new
  end

  class Blinky

    def initialize(path = File.dirname(__FILE__)) 

      Dir["#{path}/device_recipes/**/*.rb"].each { |f| require(f) }
      @recipes = Hash.new({})
      instance_eval(File.read("#{path}/recipes.rb"))

      Dir["#{path}/ci_server_plugins/**/*.rb"].each { |f| require(f) }
      @plugins = []
      instance_eval(File.read("#{path}/plugins.rb"))

      @lights = LightFactory.detect_lights(@plugins, @recipes)
    end

    def lights
      @lights
    end

    def light
      @lights.first
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