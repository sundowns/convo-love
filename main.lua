love.filesystem.setRequirePath( love.filesystem.getRequirePath()..";lib/?.lua;" )

local deck = {}
local hand = {}

function love.load(t)
   debug = false
   Util = require "lib.util"
   Class = require "lib.class"
   Gamestate = require "lib.gamestate"
   constants = require ("src.const")
   require("src.class.card")
   CardManager = require "src.cards"
   require("src.class.deck")
   require("src.class.hand")
   --require("src.conversation")

   deck = Deck()
   deck:populateStartingDeck();
   hand = Hand()
   hand:drawToMax(deck)
   --Gamestate.registerEvents()
   --Gamestate.switch(conversation)
end

function love.update(dt)
end

function love.draw()
   love.graphics.setColor(0,255,255)
   love.graphics.print("[s] Shuffle - [space] Draw hand - [p] Play from hand - [r] Reset deck", 0, love.graphics.getHeight()-20)

   deck:render()
   hand:render()

   if debug then
      Util.love.resetColour()
      Util.love.renderStats()
    end
end

function love.keypressed(key, scancode, isrepeat)
   if key == "space" then
      hand:drawToMax(deck)
   elseif key == "s" then
      deck:shuffle()
   elseif key == "r" then
      deck:reset()
   elseif key == "p" then
      local card = hand:discard()
      if not card then return end
      card.actionHandler("debug")
      deck:addCardToUsed(card)
   elseif key == "f1" then
      debug = not debug
   end
end
