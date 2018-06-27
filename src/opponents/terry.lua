local NAME = "Terry"
local ASSETS_PATH = "/opponents/terry/"

local opponent = Opponent(NAME, ASSETS_PATH)

-- Starting Stats
opponent.qualities["Patience"]:set(20)
opponent.qualities["Happiness"]:set(10)
opponent.qualities["Anger"]:set(10)
opponent.qualities["Love"]:set(0)
opponent.qualities["Pride"]:set(10)
opponent.qualities["Trust"]:set(10)

-- Dialogue options and their triggers
--TODO: Be able to do more complex triggers (namely OR/ANY)
table.insert(opponent.dialogue, Dialogue("What can I do for ya today?", { TurnCountTrigger("=", 1, "OK") }))
table.insert(opponent.dialogue, Dialogue("Shut up baby I know it",  { TurnCountTrigger(">", 1, "OK"), QualityTrigger("Patience", ">", 9, "OK") }))
table.insert(opponent.dialogue, Dialogue("Go on give Terry a kiss", { QualityTrigger("Love", ">", 4, "OK"), QualityTrigger("Patience", ">", 9, "OK")}))
table.insert(opponent.dialogue, Dialogue("Sorry pal but you are puuuutting me to sleep", { QualityTrigger("Patience", "<", 10, "OK"), QualityTrigger("Patience", ">", 4, "OK")}))
table.insert(opponent.dialogue, Dialogue("ZZZzzzzzz.....", { QualityTrigger("Patience", "<", 5, "OK")}))

--Set the initial dialogue
opponent.currentDialogue = Dialogue("Well howdy there partna'")

--Traits
table.insert(opponent.traits, TraitManager.get("mortal"))
table.insert(opponent.traits, TraitManager.get("tragic"))

return opponent
