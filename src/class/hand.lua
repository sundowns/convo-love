Hand = Class{
   init = function(self)
      self.cards = {}
      self.maxHandSize = constants.STARTING_HAND_SIZE
   end;
   add = function(self, card)
      self.cards[#self.cards+1] = card
      --need a reference so cards can be used somehow
   end;
   drawToMax = function(self, deck)
      while #self.cards < self.maxHandSize do
         self:add(deck:draw())
      end
   end;
   remove = function(self, index)
      if #self.cards > 0 and self.cards[index] then
         return table.remove(self.cards, index)
      end
   end;
   --x and y origins to render relative to
   render = function(self, x, y)
      local count = 0
      love.graphics.setColor(255, 255, 0)
      for i,card in ipairs(self.cards) do
         love.graphics.print(i.." "..card.name, x, y+count*15)
         count = count + 1
      end
   end;

}
