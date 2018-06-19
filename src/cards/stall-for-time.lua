local NAME = "Stall For Time"

local DELTAS = {
   ["Patience"]   = 5,
   ["Happiness"]  = 0,
   ["Anger"]      = 0,
   ["Love"]       = 0,
   ["Pride"]      = 0,
   ["Trust"]      = 0
}

local ACTION_HANDLER = function(event, data)
   assert(event, "Card action handler received nil event")

   if event == CARD_ACTION.activate then
      print(NAME.. " Activated")
   elseif event == CARD_ACTION.debug then
   elseif event == CARD_ACTION.tick then
   end
end

return Card(NAME, ACTION_HANDLER, DELTAS)
