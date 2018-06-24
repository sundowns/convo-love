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
         -- do this in a cooler way eventually (atm its just instant, maybe use some tweening?)
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

         -- Spoof opponent turn for now, TODO: remove
         Timer.after(2, function()
            params.turn:next(params)
         end)
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
      -- Evaluate end conditions
      local endConditions = {}
      for k,v in pairs(params.traits) do
         Util.table.concat(endConditions, params.traits[k]:evaluate(params))
      end

      if #endConditions > 0 then
         -- TODO: use the returned data to determine whether to call win or lose callbacks
         -- (how do we deal with a win and loss condition at the same time??)
         local loss = false
         local win = false
         for k, v in pairs(endConditions) do
            if v.result == "WIN" then
               win = true
            elseif v.result == "LOSE" then
               loss = true
            end
         end

         if win then
            params.callbacks.win(endConditions)
         elseif loss then
            params.callbacks.lose(endConditions)
         end
      end

      -- Run end-of-phase custom logic (should this be before evaluations?)
      STATES[self.state]:exit(params)

      -- Update state
      if STATES[self.state+1] then
         self.state = self.state + 1
      else
         self.state = 1
         self.turnCount = self.turnCount + 1
      end

      for k,v in pairs(params.traits) do
         params.traits[k]:update(params)
      end

      -- Run state enter code
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
