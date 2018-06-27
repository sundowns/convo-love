local NAME = "Terry"

local opponent = Opponent(NAME)

-- Starting Stats
opponent.qualities["Patience"]:set(20)
opponent.qualities["Happiness"]:set(10)
opponent.qualities["Anger"]:set(10)
opponent.qualities["Love"]:set(0)
opponent.qualities["Pride"]:set(10)
opponent.qualities["Trust"]:set(10)

--Dialogue
--TODO: Be able to chain triggers!!
table.insert(opponent.dialogue, Dialogue("Well howdy there partna'", { TurnCountTrigger("=", 1, "OK") }))
table.insert(opponent.dialogue, Dialogue("Shut up baby I know it",  { TurnCountTrigger(">", 1, "OK") }))
table.insert(opponent.dialogue, Dialogue("Go on give Terry a kiss", { TurnCountTrigger(">", 1, "OK") }))
table.insert(opponent.dialogue, Dialogue("I GOT 5 love ayy", { QualityTrigger("Love", "=", 5, "OK"), TurnCountTrigger(">", 1, "OK") }))

--Traits
table.insert(opponent.traits, TraitManager.get("mortal"))
table.insert(opponent.traits, TraitManager.get("tragic"))

return opponent
