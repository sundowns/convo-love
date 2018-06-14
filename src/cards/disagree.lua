local NAME = "Disagree"

local DELTAS = {
   ["Patience"]   = 0,
   ["Joy"]        = 0,
   ["Sadness"]    = 0,
   ["Anger"]      = 0,
   ["Love"]       = 0,
   ["Pride"]      = 0,
   ["Boredom"]    = 0,
   ["Trust"]      = 0
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
