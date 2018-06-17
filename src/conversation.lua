require("src.class.opponent")

conversation = {}

local hand;
local opponent;
local deck;

function conversation:init()
end;

function conversation:enter(previous, values)
   deck = values.deck
   opponent = values.opponent
   hand = Hand()
   hand:drawToMax(deck)
end;

function conversation:update(dt)
end;

function conversation:draw()
   love.graphics.setColor(0,255,255)
   love.graphics.print("[s] Shuffle - [space] Draw hand - [p] Play from hand - [r] Reset deck", 0, love.graphics.getHeight()-20)

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
end
