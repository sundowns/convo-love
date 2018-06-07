love.filesystem.setRequirePath( love.filesystem.getRequirePath()..";lib/?.lua;" )
debug = true

Util = require "lib.util"
Class = require "lib.class"
require("src.class.card")
CardManager = require "src.cards"
require("src.class.deck")

local deck;

function love.load(t)
   deck = Deck()
   deck:populateStartingDeck();
end

function love.update(dt)
end

function love.draw()
   local count = 0
   for k,card in pairs(deck.cards) do
      love.graphics.print(card.name, 0, count*20)
      count = count + 1
   end
end

function love.keypressed(key, scancode, isrepeat)
   if key == "space" then
      deck:shuffle()
   end
end
