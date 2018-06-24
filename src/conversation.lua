require("src.class.opponent")
require("src.class.turn")

conversation = {}

-- Our relevant objects
local hand;
local opponent;
local deck;
local turn;
local traits = {};

-- Booleans to make victory/defeat
local won;
local lost;

function conversation:init()
end;

function conversation:enter(previous, values)
   won = false;
   lost = false;
   turn = Turn(values.playerFirst)
   deck = values.deck
   opponent = values.opponent
   hand = Hand()
   hand:drawToMax(deck)

   traits = opponent.traits --TODO: Replace this with a concatenation between player and opponent traits!
end;

function conversation:update(dt)
   turn:update(dt, self:getContext())
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

   if win then
      love.graphics.print("U WIN : )", love.graphics.getWidth()/2, love.graphics.getHeight()*2/3)
   elseif lose then
      love.graphics.print("U LOSE : (", love.graphics.getWidth()/2, love.graphics.getHeight()*2/3)
   end
end;

function conversation:playCard(index)
   local card = hand:remove(index)
   if not card then print("[ERROR] Attempted to play null card") return end
   card:activate(self:getContext())
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
   turn:next(self:getContext())
end;

function conversation:getContext()
   return {
      deck = deck,
      hand = hand,
      opponent = opponent,
      turn = turn,
      traits = traits,
      callbacks = {
         win = self.win,
         lose = self.lose
      }}
end

function conversation:win()
   win = true
end

function conversation:lose()
   lose = true
end

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

   if not win and not lose then
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
end
