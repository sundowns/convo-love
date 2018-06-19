local NAME = "MORTAL"

--in future, they should have easy/recognizable icons
--local ICON = ""

--Called at the start of a conversation ONCE
local LAUNCH_HANDLER = function(data)
end;

--Called at the start (for now?) of EACH turn phase
local UPDATE_HANDLER = function(event, data)
   if event == "DRAW" then
   elseif event == "PLAY" then
   elseif event == "DISCARD" then
   elseif event == "OPPONENT" then
   end
end;


return Trait(NAME, LAUNCH_HANDLER, ACTION_HANDLER)
