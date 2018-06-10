Opponent = Class {
   init = function(self, name)
      self.name = name
      self.dialogue = {}
      self.qualities = {}
      for i,v in ipairs(constants.QUALITIES) do
         self.qualities[v] = 0
      end
   end;
}
