require("src.class.hand")
require("src.class.opponent")

conversation = {}

local hand;
local opponent;
local deck;

function conversation:init()
   --opponent = love.filesystem.load("src/opponents/terry.lua")
end;

function conversation:enter(previous)
   --deck = playerDeck

end;

function conversation:update(dt)
end;

function conversation:draw()

end

function conversation:keypressed(key)
--    if key == "space" then
--       hand:drawToMax(deck)
--    elseif key == "s" then
--       deck:shuffle()
--    elseif key == "r" then
--       deck:reset()
--    elseif key == "p" then
--       local card = hand:discard()
--       if not card then return end
--       card.actionHandler("debug")
--       deck:addCardToUsed(card)
--    end
end
