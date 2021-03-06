local NAME = "Mortal"
local ASSETS_PATH = "/traits/mortal/"
--in future, they should have easy/recognizable icons
--local ICON = ""

--[[ Conversation end triggers (win or lose) granted by this trait
   Acceptable result paramters: "WIN", "LOSE"
]]
local END_TRIGGERS = {
   QualityTrigger("Patience", "<", 1, "LOSE")
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
      data.opponent.qualities["Patience"]:updateBy(-2)
   end
end;


return Trait(NAME, LAUNCH_HANDLER, UPDATE_HANDLER, END_TRIGGERS, ASSETS_PATH)
