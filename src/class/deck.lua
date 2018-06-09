Deck = Class{
   init = function(self)
      self.cards = {}
      self.used = {}
   end;
   populateStartingDeck = function(self)
      self:addCardToActive(CardManager.get("agree"))
      self:addCardToActive(CardManager.get("agree"))
      self:addCardToActive(CardManager.get("disagree"))
      self:addCardToActive(CardManager.get("disagree"))
      self:addCardToActive(CardManager.get("stall-for-time"))
      self:addCardToActive(CardManager.get("stall-for-time"))
      self:shuffle(3)
   end;
   addCardToActive = function(self, card)
      self.cards[#self.cards+1] = card
   end;
   addCardToUsed = function(self, card)
      self.used[#self.used+1] = card
   end;
   -- Randomly selects a pair of values and swaps their indices
   shuffle = function(self, passes)
      -- This might just be placebo...but its a psuedo shuffle anyway
      if not passes then passes = 1 end

      for i=1, passes do
         local counter = #self.cards
         while counter > 1 do
             local index = math.random(counter)
             self:swap(index, counter)
             counter = counter - 1
         end
      end
   end;
   swap = function(self, index1, index2)
      self.cards[index1], self.cards[index2] = self.cards[index2], self.cards[index1]
   end;
   resetDeck = function(self)
      self.cards = util.concatTables(self.cards, self.used)
      self:shuffle()
   end;
   peek = function(self)
      if self.cards[1] then
         return self.cards[1]
      else
         return nil
      end
   end
}
