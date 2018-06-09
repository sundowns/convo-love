local NAME = "Agree"

local ACTION_HANDLER = function(event)
   assert(event, "Card action handler received nil event")
   if event == 'debug' then
      print(NAME)
   end
end

return Card(NAME, ACTION_HANDLER)
