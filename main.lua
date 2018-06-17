love.filesystem.setRequirePath( love.filesystem.getRequirePath()..";lib/?.lua;" )

local deck = {}

function love.load(t)
   showDebug = false
   Util = require "lib.util"
   Class = require "lib.class"
   GamestateManager = require "lib.gamestate"
   constants = require "src.const"
   require("src.class.quality")
   require("src.class.card")
   CardManager = require "src.cards"
   require("src.class.deck")
   require("src.class.hand")
   require("src.conversation")

   deck = Deck()
   deck:populateStartingDeck();

   GamestateManager.registerEvents()
   enterConversation("terry")
end

function love.update(dt)
end

function love.draw()
   if showDebug then
      Util.love.resetColour()
      Util.love.renderStats()
    end
end

function love.keypressed(key, scancode, isrepeat)
   if key == "f1" then
      showDebug = not showDebugshowDebug
   elseif key == "f5" then
      --https://www.lua.org/manual/5.1/manual.html#pdf-debug.debug
      debug.debug()
   end
end

function enterConversation(opponentKey)
   if love.filesystem.getInfo("src/opponents/"..opponentKey..".lua") then
      local opponent = love.filesystem.load("src/opponents/"..opponentKey..".lua")()
      local values = {}
      values.deck = deck
      values.opponent = opponent
      GamestateManager.switch(conversation, values)
   else
      --Probably bad practice to intentionally blue screen, like ever. Do something nicer
      assert(false, "Attempted to load non existent opponent: "..opponentKey)
   end
end
