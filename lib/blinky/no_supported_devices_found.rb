require 'pp'

module Blinky
  class NoSupportedDevicesFound < Exception
    def initialize found_devices
      @found_devices = found_devices
    end
    
    def message   
      super +
      "\nBlinky was unable to find a supported device \n" +
      "The devices I did find were:\n" +     
       "#{@found_devices.pretty_inspect}\n"
    end
    
  end
end