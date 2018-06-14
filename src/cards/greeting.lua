local NAME = "Greeting"

local DELTAS = {
   ["Patience"]   = 0,
   ["Joy"]        = 1,
   ["Sadness"]    = 1,
   ["Anger"]      = 1,
   ["Love"]       = 1,
   ["Pride"]      = 1,
   ["Boredom"]    = 1,
   ["Trust"]      = 1
}

local ACTION_HANDLER = function(event, data)
   assert(event, "Card action handler received nil event")

   print(NAME.. ":"..event)

   if event == CARD_ACTION.activate then
      Util.printTable(data)
   elseif event == CARD_ACTION.debug then
   elseif event == CARD_ACTION.tick then
   end
end

return Card(NAME, ACTION_HANDLER, DELTAS)
