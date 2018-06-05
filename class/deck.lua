Deck = Class{
   init = function(self)
      self.cards = {}
   end;
   populateStartingDeck = function(self)
      self.cards = {
         cardManager.create("Agree"),
         cardManager.create("Agree"),
         cardManager.create("Disagree"),
         cardManager.create("Disagree"),
         cardManager.create("Small Talk"),
         cardManager.create("Small Talk"),
         cardManager.create("Greeting"),
         cardManager.create("Greeting"),
         cardManager.create("Farewell"),
         cardManager.create("Farewell")
      }
   end;
}
