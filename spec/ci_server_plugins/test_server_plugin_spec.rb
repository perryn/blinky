require File.join(File.dirname(__FILE__), '..', '/spec_helper')
require 'ci_server_plugins/test_server_plugin'
module Blinky

  class StubBlinky
  end

  describe "TestCiServer" do

    before(:each) do
      @blinky = StubBlinky.new
      @blinky.extend(TestCiServer)
    end

    it "cycles through all possible statuses" do
      @blinky.should_receive(:building!).ordered
      @blinky.should_receive(:sleep).ordered
      @blinky.should_receive(:failure!).ordered
      @blinky.should_receive(:sleep).ordered
      @blinky.should_receive(:building!).ordered
      @blinky.should_receive(:sleep).ordered
      @blinky.should_receive(:warning!).ordered
      @blinky.should_receive(:sleep).ordered
      @blinky.should_receive(:building!).ordered
      @blinky.should_receive(:sleep).ordered
      @blinky.should_receive(:success!).ordered
      @blinky.should_receive(:sleep).ordered
      @blinky.should_receive(:off!).ordered

      @blinky.watch_test_server
    end

  end  
end