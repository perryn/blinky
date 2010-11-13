require File.join(File.dirname(__FILE__), '/spec_helper')

module Blinky 
  describe "Blinky" do
    
    #TODO - make some of the scenarios more explicit
     # when we have nothing matching
     # when we match vendor but not specific product
     # etc etc
    
      describe "that has autodetected a device" do
      
        before(:each) do
          @handle = mock("handle")
          @devices = [
            OpenStruct.new(:idVendor => 0x1234, :idProduct => 0x5678, :usb_open => @handle),
            OpenStruct.new(:idVendor => 0x1000, :idProduct => 0x1111, :usb_open => @handle),  
            OpenStruct.new(:idVendor => 0x5678, :idProduct => 0x1234, :usb_open => @handle)     
            ]
          USB.stub!(:devices).and_return(@devices)
          
          @indicator = Blinky::Indicator.new("#{File.dirname(__FILE__)}/fixtures/device_recipes")
        end

        it "can indicate success" do
          DeviceAsserter.should_receive(:show_success).with(0x1000, 0x1111, @handle) 
          @indicator.success!                  
        end
       
        it "can indicate failure" do
           DeviceAsserter.should_receive(:show_failure).with(0x1000, 0x1111, @handle) 
           @indicator.failure!                  
        end
        
        it "can indicate failure" do
           DeviceAsserter.should_receive(:show_building).with(0x1000, 0x1111, @handle) 
           @indicator.building!                  
        end
      end
        
        describe "that fails to autodetect a device" do

          before(:each) do
            @handle = mock("handle")
            @devices = [
              OpenStruct.new(:idVendor => 0x1234, :idProduct => 0x5678, :usb_open => @handle),
              OpenStruct.new(:idVendor => 0x5678, :idProduct => 0x1234, :usb_open => @handle)     
              ]
            USB.stub!(:devices).and_return(@devices)

          end

          it "will complain" do
            exception = Exception.new("foo")
            Blinky::NoSupportedDevicesFound.should_receive(:new).with(@devices).and_return(exception)
            lambda{Blinky::Indicator.new("#{File.dirname(__FILE__)}/fixtures/device_recipes")}.should raise_error("foo")                
          end

       
     end
   end
end