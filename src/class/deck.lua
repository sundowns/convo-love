Deck = Class{
   init = function(self)
      self.cards = {}
      self.used = {}
   end;
   populateStartingDeck = function(self)
      self:addCardToActive(CardManager.get("greeting"))
      self:addCardToActive(CardManager.get("agree"))
      self:addCardToActive(CardManager.get("agree"))
      self:addCardToActive(CardManager.get("disagree"))
      self:addCardToActive(CardManager.get("disagree"))
      self:addCardToActive(CardManager.get("stall-for-time"))
      self:addCardToActive(CardManager.get("stall-for-time"))
      self:addCardToActive(CardManager.get("sweet-talk"))
      self:addCardToActive(CardManager.get("sweet-talk"))
      self:shuffle()
   end;
   addCardToActive = function(self, card)
      self.cards[#self.cards+1] = card
   end;
   addCardToUsed = function(self, card)
      self.used[#self.used+1] = card
   end;
   -- Randomly selects a pair of values and swaps their indices
   shuffle = function(self)
      if #self.cards < 2 then return end

      local counter = #self.cards
      while counter > 1 do
          local index = love.math.random(counter)
          self:swap(index, counter)
          counter = counter - 1
      end
   end;
   swap = function(self, index1, index2)
      self.cards[index1], self.cards[index2] = self.cards[index2], self.cards[index1]
   end;
   reset = function(self)
      self.cards = Util.t.concat(self.cards, self.used)
      self.used = {}
      self:shuffle()
   end;
   peek = function(self)
      if self.cards[#self.cards] then
         return self.cards[#self.cards]
      else
         return nil
      end
   end;
   draw = function(self)
      if self.cards[#self.cards] then
         return table.remove(self.cards, #self.cards)
      else
         self:reset()
         return table.remove(self.cards, #self.cards)
      end
   end;
}
