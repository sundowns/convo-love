local NAME = "MORTAL"

--in future, they should have easy/recognizable icons
--local ICON = ""

--[[ Conversation end triggers (win or lose) granted by this trait
   Acceptable result paramters: "WIN", "LOSE"
]]
local END_TRIGGERS = {
   EndTrigger(30, ">", "Patience", "WIN") -- this should be a loss condition patience below a certain level (which should decrease each turn!)
}

--Called at the start of a conversation ONCE
local LAUNCH_HANDLER = function(data)
end;

--Called at the start (for now?) of EACH turn phase
local UPDATE_HANDLER = function(event, data)
   if event == "DRAW" then
   elseif event == "PLAY" then
   elseif event == "DISCARD" then
   elseif event == "OPPONENT" then
      --DECREASE PATIENCE by X!!
   end
end;


return Trait(NAME, LAUNCH_HANDLER, ACTION_HANDLER, END_TRIGGERS)
