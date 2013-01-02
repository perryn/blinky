module Blinky
  module ThingM
    module Blink1

      def success!
        stop 
        set_colour("\x00\xFF\x00") 
      end

      def failure!
        stop
        play   
      end

      def building! 
        stop 
        set_colour("\x00\x00\xFF") 
      end

      def warning!
        stop
        set_colour("\xFF\x2A\x00") 
      end

      def off!
        stop
        set_colour("\x00\x00\x00") 
      end

      def init
         set_flash_pattern("\xFF\x00\x00")  
      end

      private
      def set_colour colour
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01\x6E#{colour}\x00\x00\x00\x00", 0)
      end
      
      def play
         @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01p\x01\x01\x00\x00\x00\x00\x00", 0)
      end
      
      def stop
         @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01p\x00\x01\x00\x00\x00\x00\x00", 0) 
      end
      
      def set_flash_pattern colour
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P#{colour}\x00\x0A\x00\x00", 0)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x0A\x01\x00", 0)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x02\x00", 0)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x03\x00", 0) 
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x04\x00", 0) 
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x05\x00", 0) 
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x06\x00", 0) 
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x07\x00", 0) 
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x08\x00", 0) 
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x09\x00", 0) 
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x0A\x00", 0) 
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x0B\x00", 0)
      end
      
    end     
  end
end


 