module Blinky
  module FragileEngineering
    module ModelWretched

      def success! 
        @handle.indicate_success
      end

      def failure!  
        @handle.indicate_failure
      end

      def off!
        @handle.turn_off 
      end

      def init
      end

    end
  end
end