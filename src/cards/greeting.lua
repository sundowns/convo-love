local NAME = "Greeting"

local DELTAS = {
   ["Patience"]   = 0,
   ["Happiness"]  = 0,
   ["Anger"]      = 0,
   ["Love"]       = 0,
   ["Pride"]      = 0,
   ["Trust"]      = 0
}

local ACTION_HANDLER = function(event, data)
   assert(event, "Card action handler received nil event")

   if event == CARD_ACTION.activate then
      assert(data.turn)
      assert(data.opponent)
      if data.turn.turnCount == 1 then
         data.opponent.qualities["Patience"]:updateBy(5)
         data.opponent.qualities["Trust"]:updateBy(2)
      end
   elseif event == CARD_ACTION.discard then
   elseif event == CARD_ACTION.tick then
   elseif event == CARD_ACTION.debug then
   end
end

return Card(NAME, ACTION_HANDLER, DELTAS)
