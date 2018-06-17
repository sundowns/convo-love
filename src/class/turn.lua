--two way mapping, is this shit?
local STATES = {
   ["DRAW"] = 1,
   [1] = "DRAW",
   ["PLAY"] = 2,
   [2] = "PLAY",
   ["DISCARD"] = 3,
   [3] = "DISCARD",
   ["OPPONENT"] = 4,
   [4] = "OPPONENT"
}

Turn = Class {
   init = function(self, playerFirst)
      --By default, player goes first, but this can be overriden.
      if playerFirst == nil then playerFirst = true end
      if (playerFirst) then
         self.state = STATES["DRAW"]
      else
         self.state = STATES["OPPONENT"]
      end
   end;
   next = function(self)
      --TODO test this?
      self.state = STATES[self.state+1] or STATES[1]
   end;
   getState = function(self)
      return self.state
   end;
}
