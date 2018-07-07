Quality = Class {
   init = function(self, name, startValue, min, max)
      self.name = name
      self.minValue = min or constants.DEFAULTS.QUALITY_MIN
      self.maxValue = max or constants.DEFAULTS.QUALITY_MAX
      self.startValue = startValue or 0
      self.value = self.startValue
   end;
   updateBy = function(self, delta)
     print("Modifying ".. self.name .. " by " .. delta)
      self.value = self.value + delta
   end;
   set = function(self, absolute)
      self.value = absolute
   end;
   setMax = function(self, max)
     self.maxValue = max
   end;
   setMin = function(self, min)
     self.minValue = min
   end;
}
