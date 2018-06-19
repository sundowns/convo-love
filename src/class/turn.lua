-- Use turnstates for smarter turn handling.
-- Has a key and a series of optional callbacks
TurnState = Class {
   init = function(self, key, callbacks)
      if not callbacks then callbacks = {} end
      self.key = key
      self.updateCB = callbacks.update
      self.enterCB = callbacks.enter
      self.exitCB = callbacks.exit
   end;
   update = function(self, dt, params)
      if self.updateCB then self.updateCB(dt, params) end
   end;
   enter = function(self, params)
      if self.enterCB then self.enterCB(params) end
   end;
   exit = function(self, params)
      if self.exitCB then self.exitCB(params) end
   end;
}

local stateMeta = {
   __index = function(table, key)
      if tonumber(key) then
         return rawget(table,key)
      else
         if key == "DRAW" then return 1
         elseif key == "PLAY" then return 2
         elseif key == "DISCARD" then return 3
         elseif key == "OPPONENT" then return 4
         end
      end
   end;
}

local STATES = {
   [1] = TurnState("DRAW", {
      update = function(dt, params)
         params.hand:drawToMax(params.deck)
         params.turn:next(params)
      end
   }),
   [2] = TurnState("PLAY"),
   [3] = TurnState("DISCARD", {
      update = function(dt, params)
         if #params.hand.cards <= 1 then
            params.turn:next(params)
         end
      end
   }),
   [4] = TurnState("OPPONENT", {
      enter = function(params)
         params.opponent:selectDialogue()
      end,
      exit = function(params)
      end
   })
}

setmetatable(STATES, stateMeta)

Turn = Class {
   init = function(self, playerFirst)
      self.turnCount = 1
      --By default, player goes first, but this can be overriden.
      if playerFirst == nil then playerFirst = true end
      if (playerFirst) then
         self.state = STATES["PLAY"]
      else
         --Enemy first is an exception, an 'ambush' or something more contextually appropriate
         self.turnCount = 0
         self.state = STATES["OPPONENT"]
      end
   end;
   next = function(self, params)
      STATES[self.state]:exit(params)

      if STATES[self.state+1] then
         self.state = self.state + 1
      else
         self.state = 1
         self.turnCount = self.turnCount + 1
      end

      --TODO: REMOVE--> Just mocking out opponent turn for now
      if self.state == STATES["OPPONENT"] then
         Timer.after(1, function()
            self:next(params)
         end)
      end

      STATES[self.state]:enter(params)
   end;
   stateIs = function(self, key)
      return STATES[self.state].key == key
   end;
   getStateKey = function(self)
      return STATES[self.state].key
   end;
   render = function(self, x, y)
      love.graphics.setColor(0,0.6,1)
      love.graphics.print("TURN "..self.turnCount..": "..self:getStateKey(), x, y)
   end;
   update = function(self, dt, params)
      STATES[self.state]:update(dt, params)
   end
}
