Opponent = Class {
   init = function(self, name)
      self.name = name
      self.dialogue = {}
      self.qualities = {}
      self.currentDialogue = nil
      self.traits = {}
      for i,v in ipairs(constants.QUALITIES) do
         self.qualities[v] = Quality(v, 0)
      end
   end;
   --x and y origins to render relative to
   render = function(self, x, y)
      local count = 0
      love.graphics.setColor(1,1,1)
      love.graphics.print(self.name, x, y)
      love.graphics.setColor(1,0,1)
      for k,v in pairs(self.qualities) do
         love.graphics.print(k..": "..v.value, x, y+50+count*15)
         count = count+1
      end
      if self.currentDialogue then
         love.graphics.setColor(1,0,0)
         love.graphics.print(self.currentDialogue, x, y+20)
      end
   end;
   applyQualityDeltas = function(self, deltas)
      for k,v in pairs(self.qualities) do
         if deltas[k] ~= 0 then
            print("Modifying ".. k .. " by " .. deltas[k])
            self.qualities[k]:updateBy(deltas[k])
         end
      end
   end;
   selectDialogue = function(self)
      self.currentDialogue = self.dialogue[love.math.random(1,#self.dialogue)]
   end;
}
