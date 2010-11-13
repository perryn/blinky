$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'blinky'

class DeviceChecker
  
  def check
    indicator = Blinky::Indicator.new
    puts "Your Device should now be indicating 'SUCCESS'"
    indicator.success!
    sleep(2)
    puts "Your Device should now be indicating 'FAILURE'"
    indicator.failure!
    sleep(2)
    puts "Your Device should now be indicating 'BUILDING'"
    indicator.building!
    sleep(2)
    puts "CHECK COMPLETE"
  end
  
end