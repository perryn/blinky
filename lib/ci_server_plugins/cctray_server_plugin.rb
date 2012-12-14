require 'chicanery/cctray'
require 'chicanery'
module Blinky
  module CCTrayServer
    include Chicanery

    def watch_cctray_server url    
      server Chicanery::Cctray.new 'blinky build', url 

      when_run do |current_state|
        current_state.has_failure? ? failure! : success!
      end

      run_every 15
    end
  end
end