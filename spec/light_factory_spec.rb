require File.join(File.dirname(__FILE__), '/spec_helper')

module Blinky 

  module RecipeOne
  end

  module RecipeTwo
  end  

  describe "LightFactory" do

    before do

      @device_one =  double("device one", :idVendor => 0x1234, :idProduct => 0x5678)
      @device_one.stub(:open).and_return(@device_one) 
      @device_two =  double("device two",:idVendor => 0x5678, :idProduct => 0x1234) 
      @device_two.stub(:open).and_return(@device_two) 
      @connected_devices = [@device_one, @device_two]
      self.connected_devices = @connected_devices

      @plugins = [MockCiPlugin]
    end

    it "will build a light for each connected device for which we have a recipe" do
      recipes = Hash.new({})
      recipes[0x1234] = {0x5678 => RecipeOne}
      recipes[0x5678] = {0x1234 => RecipeTwo}

      Light.should_receive(:new).with(@device_one, RecipeOne , @plugins).and_return("light one")
      Light.should_receive(:new).with(@device_two, RecipeTwo , @plugins).and_return("light two")

      lights = LightFactory.detect_lights(@plugins, recipes)
      lights.should include "light one"
      lights.should include "light two"
    end     

    it "will not build a light for a connected device for which we have no recipe" do
      recipes = Hash.new({})
      recipes[0x1234] = {0x5678 => RecipeOne}

      Light.stub!(:new).and_return("no recipe light")
      Light.should_receive(:new).with(@device_one, RecipeOne , @plugins).and_return("light one")

      lights = LightFactory.detect_lights(@plugins, recipes)
      lights.should eql ["light one"]
    end

    it "will complain if there are no connected lights for which we have a recipe" do
      recipes = Hash.new({})
      recipes[0x9999] = {0x9999 => RecipeOne}

      exception = Exception.new("foo")
      NoSupportedDevicesFound.should_receive(:new).with(@connected_devices).and_return(exception)
      lambda{LightFactory.detect_lights(@plugins, recipes)}.should raise_error("foo")
    end

    def connected_devices= devices
      devices.each do |device|
        device.stub!(:usb_open).and_return(device)
      end
      USB.stub!(:devices).and_return(devices)
    end

  end
end