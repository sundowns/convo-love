Trait = Class {
   init = function(self, name, launchHandler, updateHandler)
      self.name = name
      self.launchHandler = launchHandler
      self.updateHandler = updateHandler
   end;
   launch = function(self, params)
      if self.launchHandler then
         self.launchHandler(params)
      end
   end;
   update = function(self, event, params)
      if self.updateHandler then
         self.updateHandler(event, params)
      end
   end;
}
