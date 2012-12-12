module Blinky
  module TestCiServer
    def watch_test_server
      puts "BUILDING!"
      building!
      sleep(2)
      puts "-"

      puts "BUILD FAILED!"
      failure!
      sleep(2)
      puts "-"

      puts "BUILDING!\n"
      building!
      sleep(2)
      puts "-"

      puts "WARNING!\n"
      warning!
      sleep(2)
      puts "-"

      puts "BUILDING!\n"
      building!
      sleep(2)
      puts "-"

      puts "BUILD PASSED!\n"
      success!
      sleep(2)
      puts "-"

      puts "TEST OVER\n"
      off!

    end
  end
end