Card = Class{
   init = function(self, name)
      self.name = name
   end;
   description = function(self)
      print("I am "..self.name)
   end;
   action = function(self)
      --Maybe an overridable custom function?
   end;
}
