Hand = Class{
   init = function(self)
      self.cards = {}
      self.maxHandSize = constants.DEFAULTS.HAND_SIZE
   end;
   add = function(self, card)
      self.cards[#self.cards+1] = card
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
   --Apply a function to all cards in the hand
   --Iterates back to front so we can modify the contents safely!
   forAll = function(self, func, params)
      for i = #self.cards, 1, -1 do
         func(i, params)
      end
   end;
   count = function(self)
      return #self.cards
   end;

}
