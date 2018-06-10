local QUALITY_MAX = 100
local QUALITY_MIN = 0

Quality = Class {
   init = function(self, name, startValue)
      self.name = name
      self.minValue = QUALITY_MIN
      self.startValue = startValue
      self.value = startValue
      self.maxValue = QUALITY_MAX
   end;
   update = function(self, delta)
      self.value = self.value + delta
   end;
}
