local NAME = "Greeting"

local ACTION_HANDLER = function(event)
   assert(event, "Card action handler received nil event")
   if event == 'debug' then
      print(NAME.. " actioned")
   end
end

return Card(NAME, ACTION_HANDLER)
