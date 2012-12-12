require 'pp'

module Blinky
  class NoSupportedDevicesFound < RuntimeError
    def initialize found_devices
      @found_devices = found_devices
    end

    #TODO - this doesn't work with ribusb  - there is no nice inspect method
    def to_s  
      "Blinky was unable to find a supported device \n" +
      "The devices I did find were:\n" +     
      "#{@found_devices.pretty_inspect}\n"
    end

  end
end