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
         local triggered = self.endTriggers[k]:evaluate(params.opponent.qualities)
         if triggered then
            results[#results+1] = triggered
         end
      end
      return results
   end;
}

--TODO: Render these in the conversation somehow so u know what ur working towards (maybe post UI?)
EndTrigger = Class {
   init = function(self, quality, operator, value, result)
      assert(operator == ">" or operator == "=" or operator == "<")
      self.value = value
      self.operator = operator
      self.quality = quality
      self.result = result
   end;
   --This might need to receive more than qualities in future
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
         return {
            result = self.result,
            quality = self.quality
         }
      end
   end;
}
