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
   --turn = Turn(values.playerFirst)
   deck = values.deck
   opponent = values.opponent
   hand = Hand()
   hand:drawToMax(deck)
end;

function conversation:update(dt)
end;

function conversation:draw()
   love.graphics.setColor(0,255,255)
   love.graphics.print("[s] Shuffle - [space] Draw hand - [1,2,3..] Play from hand - [r] Reset deck", 0, love.graphics.getHeight()-20)

   deck:render(10, 5)
   hand:render(love.graphics.getWidth()/2-100, 5)

   opponent:render(10, love.graphics.getHeight()/2)
end;

function conversation:playCard(card)
   if not card then print("[ERROR] Attempted to play null card") return end
   card:activate({opponent = opponent})
   deck:addCardToUsed(card)
end;

function conversation:keypressed(key)
   --if turn.state == "PLAY" then
      if key == "space" then
         hand:drawToMax(deck)
      elseif key == "s" then
         deck:shuffle()
      elseif key == "r" then
         deck:reset()
      elseif tonumber(key) then
         local card = hand:remove(tonumber(key))
         conversation:playCard(card)
      end
   --end
end
