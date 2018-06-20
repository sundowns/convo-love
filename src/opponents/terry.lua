local NAME = "Terry"

local opponent = Opponent(NAME)

-- Starting Stats
opponent.qualities["Patience"]:set(20)
opponent.qualities["Happiness"]:set(10)
opponent.qualities["Anger"]:set(10)
opponent.qualities["Love"]:set(10)
opponent.qualities["Pride"]:set(10)
opponent.qualities["Trust"]:set(10)

table.insert(opponent.dialogue, "Well howdy there partna'")
table.insert(opponent.dialogue, "Shut up baby I know it")
table.insert(opponent.dialogue, "Go on give Terry a kiss")

return opponent
