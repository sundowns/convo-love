conversation = {}

-- Our relevant objects
local hand
local opponent
local deck
local turn
local traits = {}

-- Our UI handler
local ui = require("src.uimanager")

-- Booleans to make victory/defeat
local won
local lost

function conversation:init()
  local textBoxYOffset = ui:fromHeight("header_height") + ui:fromHeight("qualities_height")
  Moan.setBoxBounds(0, textBoxYOffset, ui:fromWidth("textbox_width"), ui:fromHeight("textbox_height"))
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
end

function conversation:update(dt)
  turn:update(dt, self:getContext())
  opponent:update(dt)

  nk.frameBegin()
    -- BASE UI
    -- Header bar
    if nk.windowBegin("header", 0, 0, love.graphics.getWidth(), love.graphics.getHeight()*ui.constants.header_height) then
      local width,height = nk.windowGetSize()
      nk.layoutRow('dynamic', math.floor(height*0.8), {0.1, 0.8, 0.1})
      if nk.button("Deck ["..#deck.cards.."]") then
        if ui.toggles.show_deck then
          ui:disable("show_deck")
        else
          --ui:disable("show_used")
          ui:enable("show_deck")
        end
      end
      nk.label("TURN "..turn.turnCount..": "..turn:getStateKey(), "centered")
      if nk.button("Discard ["..#deck.used.."]") then
        -- if ui.toggles.show_used then
        --   ui:disable("show_used")
        -- else
        --   ui:disable("show_deck")
        --   ui:enable("show_used")
        -- end
      end
    end
    nk.windowEnd()

    -- Player Hand
    if nk.windowBegin("handWindow", 0, love.graphics.getHeight()*(1-ui.constants.hand_height), love.graphics.getWidth(), love.graphics.getHeight()*ui.constants.hand_height, 'border') then
      local width, height = nk.windowGetSize()
      nk.layoutRow('dynamic', math.floor(height*.95), #hand.cards)
        for i, card in ipairs(hand.cards) do
          nk.layoutRowPush(1/#hand.cards)
          if nk.button(card.name) then
            if not win and not lose then
              if turn:stateIs("PLAY") then
                conversation:playCard(i)
                conversation:nextPhase()
              elseif turn:stateIs("DISCARD") then
                conversation:discardDownTo(i)
              end
            end
          end
        end
    end
    nk.windowEnd() -- End Player Hand

    -- Card Window
    if nk.windowBegin("cardWindow", 0, ui:fromHeight("header_height"), ui:fromWidth("card_width"), ui:fromHeight("card_height")) then

    end
    nk.windowEnd() -- End Card Window

    -- Qualities Window
    if nk.windowBegin("qualitiesWindow", ui:fromWidth("card_width"), ui:fromHeight("header_height"), ui:fromWidth("qualities_width"), ui:fromHeight("qualities_height")) then
      local width, height = nk.windowGetSize()
      local rowHeight = math.floor(height/#constants.QUALITIES*0.925)
      for k, v in pairs(opponent.qualities) do
        nk.layoutRow('dynamic', rowHeight, {0.3, 0.7})
        nk.label(k.." ["..v.value.."]")
        --TODO: Try using nuklear's free drawing functions to make these nicer!
        local current = nk.progress(v.value, v.maxValue)
      end
    end
    nk.windowEnd() -- End Qualities Window

    -- Traits Window
    if nk.windowBegin("traitsWindow", ui:fromWidth("qualities_width") + ui:fromWidth("card_width"), ui:fromHeight("header_height"), ui:fromWidth("traits_width"), ui:fromHeight("traits_height")) then

    end
    nk.windowEnd() -- End Traits Window

    -- Name Window
    if nk.windowBegin("nameWindow", ui:fromWidth("qualities_width") + ui:fromWidth("card_width") + ui:fromWidth("traits_width"), ui:fromHeight("header_height"), ui:fromWidth("name_width"), ui:fromHeight("name_height")) then
      local x, y, width, height = nk.windowGetBounds()
      nk.text(opponent.name, x + width/3, y+height/3, width, height)
    end
    nk.windowEnd() -- End Name Window

    -- Opponent Portait Window
    if nk.windowBegin("portraitWindow", ui:fromWidth("qualities_width") + ui:fromWidth("card_width") + ui:fromWidth("traits_width"), ui:fromHeight("header_height") + ui:fromHeight("name_height"), ui:fromHeight("portrait_edge"), ui:fromHeight("portrait_edge")) then
      local width, height = nk.windowGetSize()
      if opponent.anim.image then
        nk.image(opponent.anim.image, nk.windowGetBounds())
      end
    end
    nk.windowEnd() -- End Potrait Window

    -- OVERLAYS
    -- Deck Overlay
    if ui.toggles.show_deck then
      if nk.windowBegin("deckWindow", love.graphics.getWidth()*0.1, love.graphics.getHeight()*0.1, love.graphics.getWidth()*0.8, love.graphics.getHeight()*0.8) then
        local width, height = nk.windowGetSize()
        local rows = math.ceil(#deck.cards/ui.constants.deck_items_per_row)
        local count = 0
        for k, card in pairs(deck.cards) do
          if count % ui.constants.deck_items_per_row == 0 then
            nk.layoutRow('dynamic', math.floor(height*0.9)/rows, ui.constants.deck_items_per_row)
          end
          nk.label(card.name)
          count = count + 1
        end
      end
      nk.windowEnd() -- End Deck Overlay
    end
    -- Discard Pile Overlay
    if ui.toggles.show_used then
      if nk.windowBegin("discardWindow", love.graphics.getWidth()*0.1, love.graphics.getHeight()*0.1, love.graphics.getWidth()*0.8, love.graphics.getHeight()*0.8) then
        local width, height = nk.windowGetSize()
        local rows = math.ceil(#deck.used/ui.constants.deck_items_per_row)
        local count = 0
        for k, card in pairs(deck.used) do
          if count % ui.constants.deck_items_per_row == 0 then
            nk.layoutRow('dynamic', math.floor(height*0.9)/rows, ui.constants.deck_items_per_row)
          end
          nk.label(card.name)
          count = count + 1
        end
      end
      nk.windowEnd() -- End Deck Overlay
    end

  nk.frameEnd()
end

function conversation:draw()
  Util.love.resetColour()
  Moan:draw()
  nk.draw()

  if win then
    love.graphics.print("U WIN : )", love.graphics.getWidth()/2, love.graphics.getHeight()*2/3)
  elseif lose then
    love.graphics.print("U LOSE : (", love.graphics.getWidth()/2, love.graphics.getHeight()*2/3)
  end

  --Reset colour to prepare for immediate UI
  Util.love.resetColour()
end

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

function conversation:keypressed(key, scancode, isrepeat)
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
