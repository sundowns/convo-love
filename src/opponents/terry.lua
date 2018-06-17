local NAME = "Terry"

local opponent = Opponent(name)

-- Starting Stats
opponent.qualities["Patience"]:set(20)
opponent.qualities["Joy"]:set(10)
opponent.qualities["Sadness"]:set(10)
opponent.qualities["Anger"]:set(10)
opponent.qualities["Love"]:set(10)
opponent.qualities["Pride"]:set(10)
opponent.qualities["Boredom"]:set(10)
opponent.qualities["Trust"]:set(10)

opponent.dialogue["intro"] = "Well howdy there partna'"

return opponent
