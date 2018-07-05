love.filesystem.setRequirePath( love.filesystem.getRequirePath()..";lib/?.lua;")

local deck = {}

function love.load(t)
  showDebug = false
  Util = require "lib.util"
  Class = require "lib.class"
  Timer = require "lib.timer"
  GamestateManager = require "lib.gamestate"
  GamestateManager.registerEvents()
  nk = require 'nuklear'
  Assets = require("lib.cargo").init('assets')
  constants = require ("src.const")
  require("src.class.dialogue")
  require("src.class.quality")
  require("src.class.trigger")
  require("src.class.card")
  require("src.class.trait")
  CardManager = require "src.cardmanager"
  TraitManager = require "src.traitmanager"
  require("src.class.deck")
  require("src.class.hand")
  require("src.conversation")
  love.graphics.setDefaultFilter('nearest')

  deck = Deck()
  deck:populateStartingDeck();

  nk.init()
  enterConversation("terry")
end

function love.update(dt)
  Timer.update(dt)
end

function love.draw()
  if showDebug then
    Util.l.resetColour()
    Util.l.renderStats()
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

function love.keypressed(key, scancode, isrepeat)
  if key == "f1" then
    showDebug = not showDebug
  elseif key == "f5" then
    --https://www.lua.org/manual/5.1/manual.html#pdf-debug.debug
    debug.debug()
  elseif key == "escape" then
    love.event.quit()
  elseif key == "tab" then
    love.event.quit("restart")
  end

  if nk.keypressed(key, scancode, isrepeat) then
    return
  end
end

function love.keyreleased(key, scancode)
	if nk.keyreleased(key, scancode) then
		return -- event consumed
	end
end

function love.mousepressed(x, y, button, istouch)
	if nk.mousepressed(x, y, button, istouch) then
		return -- event consumed
	end
end

function love.mousereleased(x, y, button, istouch)
	if nk.mousereleased(x, y, button, istouch) then
		return -- event consumed
	end
end

function love.mousemoved(x, y, dx, dy, istouch)
	if nk.mousemoved(x, y, dx, dy, istouch) then
		return -- event consumed
	end
end

function love.textinput(text)
	if nk.textinput(text) then
		return -- event consumed
	end
end
