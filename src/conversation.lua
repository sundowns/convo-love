require("src.class.opponent")
require("src.class.turn")

conversation = {}

local hand;
local opponent;
local deck;
local turn;

function conversation:init()
end;

function conversation:enter(previous, values)
   turn = Turn(values.playerFirst)
   deck = values.deck
   opponent = values.opponent
   hand = Hand()
   hand:drawToMax(deck)
end;

function conversation:update(dt)
   turn:update(dt, {deck=deck,hand=hand,opponent=opponent,turn=turn})
   --[[Check for win conditions? (we could do this in our traits,
   but we might be better off pooling them and doing it in conversation).
   e.g. what if we want to prevent one trait taking effect?
   ]]
end;

function conversation:draw()
   love.graphics.setColor(0,1,1)
   if turn:stateIs("PLAY") then
      love.graphics.print("[1,2,3..] Play from hand", love.graphics.getWidth()/2, love.graphics.getHeight()/2)
   elseif turn:stateIs("DISCARD") then
      love.graphics.print("[1,2,3..] Discard down to", 0, love.graphics.getHeight()-20)
   end

   deck:render(10, 5)
   hand:render(love.graphics.getWidth()/2-100, 5)
   opponent:render(10, love.graphics.getHeight()/2)
   turn:render(love.graphics.getWidth()/2, love.graphics.getHeight()/2-20)
end;

function conversation:playCard(index)
   local card = hand:remove(index)
   if not card then print("[ERROR] Attempted to play null card") return end
   -- Likely to add more data as we add new cards, but lets not go overboard yet
   card:activate({opponent=opponent, turn=turn})
   deck:addCardToUsed(card)
end;

function conversation:discardDownTo(index)
   local card = hand:remove(index)
   if not card then print("[ERROR] Attempted to discard down to null card") return end

   hand:forAll(function(i, params)
      params.deck:addCardToUsed(params.hand:remove(i))
   end, {deck=deck,hand=hand})

   hand:add(card)
end;

function conversation:nextPhase()
   turn:next({deck=deck,hand=hand,opponent=opponent,turn=turn})
end;

function conversation:keypressed(key)
   if showDebug then
      if key == "space" then
         hand:drawToMax(deck)
      elseif key == "s" then
         deck:shuffle()
      elseif key == "r" then
         deck:reset()
      end
   end

   if turn:stateIs("PLAY") then
      if tonumber(key) then
         conversation:playCard(tonumber(key))
         conversation:nextPhase()
      end
   elseif turn:stateIs("DISCARD") then
      if tonumber(key) then
         conversation:discardDownTo(tonumber(key))
      end
   end
end
