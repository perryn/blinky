module Blinky
  module AenimaEngineering
    module Model462     
      def show_success handle
        DeviceAsserter.show_success(0x1000, 0x1111, handle) 
      end
      
      def show_failure handle
        DeviceAsserter.show_failure(0x1000, 0x1111, handle) 
      end
      
      def show_building handle
        DeviceAsserter.show_building(0x1000, 0x1111, handle) 
      end
      
    end
  end
end