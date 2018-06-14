Opponent = Class {
   init = function(self, name)
      self.name = name
      self.dialogue = {}
      self.qualities = {}
      for i,v in ipairs(constants.QUALITIES) do
         self.qualities[v] = 0
      end
   end;
   --x and y origins to render relative to
   render = function(self, x, y)
      local count = 0
      love.graphics.setColor(255,0,255)
      for k,v in pairs(self.qualities) do
         love.graphics.print(k..": "..v, x, y+count*15)
         count = count+1
      end
   end;
   applyQualityDeltas = function(self, deltas)
      for k,v in pairs(self.qualities) do
         if deltas[k] then
            print("Modifying ".. k .. " by " .. deltas[k])
            self.qualities[k] = self.qualities[k] + deltas[k]
         end
      end
   end;
}
