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
   update = function(self, event, params)
      if self.updateHandler then
         self.updateHandler(event, params)
      end

      for k,v in pairs(self.endTriggers) do
         self.endTriggers[k]:evaluate(params.opponent.qualities)
      end
   end;
}

EndTrigger = Class {
   init = function(self, value, operator, quality, result)
      assert(operator == ">" or operator == "=" or operator == "<")
      self.value = value
      self.operator = operator
      self.quality = quality
      self.result = result
   end;
   evaluate = function(self, qualities)
      assert(qualities)
      local triggered = false
      if self.operator == ">" then
         triggered = qualities[self.quality].value > self.value
      elseif self.operator == "=" then
         triggered = qualities[self.quality].value == self.value
      elseif self.operator == "<" then
         triggered = qualities[self.quality].value < self.value
      end

      if triggered then
         --TODO: Do something more meaningful here, return a table that can be evaluated in conversation?
         print(self.result)
      end
   end;
}
