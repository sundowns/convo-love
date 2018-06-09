--[[ Card
   * actionHandler is a customizable function to be specified per card. Will probably end up with a
   few of these for different timings (or an event parameter instead?)
]]

Card = Class{
   init = function(self, name, actionHandler)
      self.name = name
      assert(actionHandler == nil or type(actionHandler) == "function",
         "Action Handler must either be nil or a function")
      self.actionHandler = actionHandler
   end;
   description = function(self)
      print("I am "..self.name)
   end;
}
