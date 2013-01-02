module Blinky
  class Light

    def initialize device_handle, recipe, plugins
      @handle = device_handle
      self.extend(recipe)   
      plugins.each do |plugin|
        self.extend(plugin)
      end    
      self.init      
    end

    def where_are_you?
      5.times do
        failure!
        sleep(0.5)
        success!
        sleep(0.5)
      end
      off!      
    end

  end
end