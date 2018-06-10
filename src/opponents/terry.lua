local NAME = "Terry"

local opponent = Opponent(name)

-- Starting Stats
opponent.qualities["Patience"] = 20
opponent.qualities["Joy"] = 10
opponent.qualities["Sadness"] = 10
opponent.qualities["Anger"] = 10
opponent.qualities["Love"] = 10
opponent.qualities["Pride"] = 10
opponent.qualities["Boredom"] = 10
opponent.qualities["Trust"] = 10

opponent.dialogue["intro"] = "Well howdy there partna'"

return opponent
