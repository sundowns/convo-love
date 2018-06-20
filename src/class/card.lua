--[[ Card
   * actionHandler is a customizable function to be specified per card. Will probably end up with a
   few of these for different timings (or an event parameter instead?)
]]

CARD_ACTION = {
   activate = 1,
   discard = 2,
   tick = 3,
   debug = 4
}

Card = Class{
   init = function(self, name, actionHandler, deltas)
      self.name = name
      assert(actionHandler == nil or type(actionHandler) == "function",
         "Action Handler must either be nil or a function")
      self.actionHandler = actionHandler
      self.deltas = deltas
   end;
   description = function(self)
      print("I am "..self.name)
   end;
   --context is an object containing anything needed to execute.
   activate = function(self, context)
      assert(context.opponent, self.name.." - received non-existent opponent to card activation function")

      --apply change in qualities first
      context.opponent:applyQualityDeltas(self.deltas)

      self.actionHandler(CARD_ACTION.activate, context)

   end;
}
