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
      self:addCardToActive(CardManager.get("greeting"))
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
          local index = math.random(counter)
          self:swap(index, counter)
          counter = counter - 1
      end
   end;
   swap = function(self, index1, index2)
      self.cards[index1], self.cards[index2] = self.cards[index2], self.cards[index1]
   end;
   reset = function(self)
      self.cards = Util.concatTables(self.cards, self.used)
      self.used = {}
      self:shuffle()
   end;
   peek = function(self)
      if self.cards[#self.cards] then
         return self.cards[#self.cards]
      else
         return nila
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
   --Renderer function
   --x and y origins to render relative to
   render = function(self, x, y)
      local count = 0
      local lastActiveYOffset = 0
      love.graphics.setColor(0, 1, 0)
      for k,card in pairs(self.cards) do
         love.graphics.print(card.name, x, y+count*15)
         count = count + 1
         lastActiveYOffset = count*15
      end

      --draw last offset(top card)
      love.graphics.setColor(1,1,0)
      love.graphics.circle('fill', x+3, y+lastActiveYOffset, 3)

      -- Draw used pile
      love.graphics.setColor(1, 0, 0)
      count = 0
      for k,card in pairs(self.used) do
         love.graphics.print(card.name, x+love.graphics.getWidth()-100, y+count*15)
         count = count + 1
      end
   end;
}
