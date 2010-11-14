module Blinky
  module TestCiServer
    def watch_test_server
      puts "BUILDING!\n"
      building!
      sleep(2)
      
      puts "BUILD FAILED!\n"
      failure!
      sleep(2)
      
      puts "BUILDING!\n"
      building!
      sleep(2)
      
      puts "I AM 12 AND WHAT IS THIS?\n"
      warning!
      sleep(2)
      
      puts "BUILDING!\n"
      building!
      sleep(2)
      
      puts "BUILD PASSED!\n"
      success!
      sleep(2)
      
      puts "TEST OVER\n"
      off!
      
    end
  end
end