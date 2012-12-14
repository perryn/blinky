require File.join(File.dirname(__FILE__), '/spec_helper')

module Blinky 
  describe "Blinky" do

    describe "that has a supported device connected" do

      before(:each) do
        @supported_device = double("supported device",:idVendor => 0x2000, :idProduct => 0x2222)
        @supported_device.stub(:open).and_return(@supported_device)       
        self.connected_devices = [
          double("unsupported device A",:idVendor => 0x1234, :idProduct => 0x5678),
          @supported_device,
          double("unsupported device B",:idVendor => 0x5678, :idProduct => 0x1234)     
        ]
        @blinky = Blinky.new("#{File.dirname(__FILE__)}/fixtures")
      end

      it "will provide a single light" do
        @blinky.light.should_not be_nil
        @blinky.lights.length.should == 1
      end

      it "can provide a light that can control the device" do
        @supported_device.should_receive(:indicate_success)
        @blinky.light.success!                  
      end

      it "can provide a light that can show where it is" do
        @supported_device.should_receive(:indicate_failure).ordered
        @supported_device.should_receive(:indicate_success).ordered
        @supported_device.should_receive(:indicate_failure).ordered
        @supported_device.should_receive(:indicate_success).ordered
        @supported_device.should_receive(:indicate_failure).ordered
        @supported_device.should_receive(:indicate_success).ordered
        @supported_device.should_receive(:indicate_failure).ordered
        @supported_device.should_receive(:indicate_success).ordered
        @supported_device.should_receive(:indicate_failure).ordered
        @supported_device.should_receive(:indicate_success).ordered
        @supported_device.should_receive(:turn_off).ordered

        @blinky.light.where_are_you?
      end

    end

    describe "that supports two devices from the same vendor" do

      it "can provide a light that can control the first device" do
        supported_device_one = double("supported device one", :idVendor => 0x1000, :idProduct => 0x1111) 
        supported_device_one.stub(:open).and_return(supported_device_one)       
        self.connected_devices = [supported_device_one]
        @blinky = Blinky.new("#{File.dirname(__FILE__)}/fixtures")
        supported_device_one.should_receive(:indicate_success)
        @blinky.light.success!                  
      end

      it "can provide a light that can control the second device" do
        supported_device_two = double("supported device two", :idVendor => 0x1000, :idProduct => 0x2222) 
        supported_device_two.stub(:open).and_return(supported_device_two)      
        self.connected_devices = [supported_device_two]
        @blinky = Blinky.new("#{File.dirname(__FILE__)}/fixtures")
        supported_device_two.should_receive(:indicate_success)
        @blinky.light.success!                 
      end
    end

    describe "that has no supported devices connected" do

      before(:each) do
        @devices = [
          double("unsupported device", :idVendor => 0x1234, :idProduct => 0x5678),
          double("unsupported device", :idVendor => 0x5678, :idProduct => 0x1234)     
        ]
        self.connected_devices= @devices
      end

      it "will complain" do
        exception = Exception.new("foo")
        NoSupportedDevicesFound.should_receive(:new).with(@devices).and_return(exception)
        lambda{Blinky.new("#{File.dirname(__FILE__)}/fixtures")}.should raise_error("foo")                
      end

    end

    describe "that has no supported devices connected - but does have one from the same vendor" do

      before(:each) do
        @devices = [
          double("unsupported device from known vendor", :idVendor => 0x1000, :idProduct => 0x5678),
          double("unsupported device", :idVendor => 0x5678, :idProduct => 0x1234)     
        ]
        self.connected_devices= @devices
      end

      it "will complain" do
        exception = Exception.new("foo")
        NoSupportedDevicesFound.should_receive(:new).with(@devices).and_return(exception)
        lambda{Blinky.new("#{File.dirname(__FILE__)}/fixtures")}.should raise_error("foo")                
      end

    end

    describe "that has two supported devices connected" do

      before(:each) do
        @supported_device_one = double("supported device A",:idVendor => 0x1000, :idProduct => 0x1111)
        @supported_device_one.stub(:open).and_return(@supported_device_one)   
        @supported_device_two = double("supported device B",:idVendor => 0x2000, :idProduct => 0x2222)      
        @supported_device_two.stub(:open).and_return(@supported_device_two) 
         
        self.connected_devices = [
          double("unsupported device", :idVendor => 0x1234, :idProduct => 0x5678),
          @supported_device_one,
          @supported_device_two    
        ]
        @blinky = Blinky.new("#{File.dirname(__FILE__)}/fixtures")
      end

      it "will provide two lights" do
        @blinky.light.should_not be_nil
        @blinky.lights.length.should == 2
      end

      it "can provide lights that can control thedevices" do
        @supported_device_one.should_receive(:indicate_success)
        @supported_device_two.should_receive(:indicate_success)
        @blinky.lights[0].success! 
        @blinky.lights[1].success!                 
      end
    end

    describe "that provides a light that is asked to watch a supported CI server" do

      before(:each) do   
        device = double("device",:idVendor => 0x1000, :idProduct => 0x1111) 
        device.stub(:open).and_return(device)
        self.connected_devices = [device]
        @light = Blinky.new("#{File.dirname(__FILE__)}/fixtures").light
      end

      it "can receive call backs from the server" do
        @light.should_receive(:notify_build_status)
        @light.watch_mock_ci_server                  
      end

    end

    def connected_devices= devices
      devices.each do |device|
        device.stub!(:usb_open).and_return(device)
      end
      USB.stub!(:devices).and_return(devices)
    end

  end   
end