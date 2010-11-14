module Blinky
  module DelcomEngineering
    module Model804005
             
      def success! 
        set_colour(GREEN) 
      end
      
      def failure!  
        set_colour(RED) 
      end
      
      def building!  
        set_colour(BLUE)
      end
      
      def warning!
        set_colour(YELLOW)
      end
      
      def off!
        set_colour(0xFF)  
      end
      
      private
      def set_colour colour
        begin
         @handle.usb_control_msg(0xc8, 0x12, 0x020a, colour,"",0) 
        rescue  Errno::EPIPE
          # broken pipe error are always thrown here - this is fixed in the ribusb branch
        end  
      end
      
      GREEN = 0xFF && ~0x01
      RED = 0xFF && ~0x02
      BLUE = 0xFF && ~0x04
      YELLOW = 0xFF && ~0x03
      
    end
  end
end