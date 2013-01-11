module Blinky
  module DreamCheeky
    module WebmailNotifier

      def success!
        colour!("\x00\xFF\x00") 
      end

      def failure!
        colour!("\xFF\x00\x00") 
      end

      def building! 
        colour!("\x00\x00\xFF") 
      end

      def warning!
        colour!("\xFF\x2A\x00") 
      end

      def off!
        colour!("\x00\x00\x00") 
      end

      def init
        send "\x1f\x02\x00\x2e\x00\x00\x2b\x03"
        send "\x00\x02\x00\x2e\x00\x00\x2b\x04"
        send "\x00\x00\x00\x2e\x00\x00\x2b\x05"
      end

      def colour!(colour)
        send(colour + "\x00\x00\x00\x00\x05")  
      end

      private
      def send(data)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, data, 0)
      end

    end     
  end
end