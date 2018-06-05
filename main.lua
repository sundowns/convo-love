love.filesystem.setRequirePath( love.filesystem.getRequirePath()..";lib/?.lua;" )

Class = require "lib.class"
require("class.card")
cardManager = require "src.cards"
require("class.deck")

local deck;

function love.load(t)
   deck = Deck()
   deck.populateStartingDeck();
end

function love.update(dt)
end

function love.draw()
   for i,card in ipairs(deck) do
      love.graphics.draw(card.name, 0, i*20)
   end
end
