module Blinky
  module DelcomEngineering
    module VisualIndicator
      module GenerationI

        def success! 
          set_colour(0xFF && ~0x01) 
        end

        def failure!  
          set_colour(0xFF && ~0x02) 
        end

        def building!  
          set_colour(0xFF && ~0x04)
        end

        def warning!
          set_colour(0xFF && ~0x03)
        end

        def off!
          set_colour(0xFF)  
        end

        def init
        end

        private
        def set_colour colour
          begin
            @handle.usb_control_msg(0xc8, 0x12, 0x020a, colour,"",0) 
          rescue  Errno::EPIPE
            # broken pipe error are always thrown here - this is fixed in the ribusb branch
          end  
        end
      end     
    end
  end
end