module Blinky
  module DelcomEngineering
    module Model804005
      
      GREEN = 0xFF && ~0x01
      RED = 0xFF && ~0x02
      BLUE = 0xFF && ~0x04
              
      def success! 
        set_colour(GREEN) 
      end
      
      def failure!  
        set_colour(RED) 
      end
      
      def building!  
        set_colour(BLUE)
      end
      
      def off!
        set_colour(0xFF)
      end
      
      private
      def set_colour colour
        @device.controlTransfer(:bmRequestType => 0xc8, :bRequest => 0x12, :wValue => 0x020a, :wIndex => colour)
      end
      
    end
  end
end