Trait = Class {
   init = function(self, name, launchHandler, updateHandler, endTriggers)
      self.name = name
      self.launchHandler = launchHandler
      self.updateHandler = updateHandler
      self.endTriggers = endTriggers
   end;
   launch = function(self, params)
      if self.launchHandler then
         self.launchHandler(params)
      end
   end;
   -- Called ONCE at the start of a new phase
   update = function(self, params)
      if self.updateHandler then
         self.updateHandler(params.turn:getStateKey(), params)
      end
   end;
   -- Called ONCE at the VERY end of a phase
   evaluate = function(self, params)
      local results = {}
      for k,v in pairs(self.endTriggers) do
         local triggered = self.endTriggers[k]:evaluate(params)
         if triggered then
            results[#results+1] = triggered
         end
      end
      return results
   end;
}
