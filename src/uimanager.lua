local toggles = {
  ["show_deck"] = false,
  ["show_used"] = false
}

local constants = {
  ["deck_items_per_row"] = 5, -- 5 cards per row in overlays
  ["header_height"] = 0.05, --5% of screen height
  ["hand_height"] = 0.30, --30% of screen height
  ["card_height"] = 0.5, --50% of screen height
  ["card_width"] = 0.265, --20% of screen height
  ["qualities_height"] = 0.5, -- 50% of screen height
  ["qualities_width"] = 0.35, -- 35%
  ["portrait_edge"] = 0.45, -- 45% (Portraits should be square)
  ["name_height"] = 0.05, -- 5%
  ["name_width"] = 0.45, -- 45%
  ["traits_height"] = 0.5, -- 50%
  ["traits_width"] = 0.05, -- 5%
  ["textbox_width"] = 1, -- 100%
  ["textbox_height"] = 0.15, -- 15%
  ["deck_overlay_width"] = 0.80, -- 80%
  ["deck_overlay_height"] = 0.80, -- 80%
  ["discard_overlay_width"] = 0.80, -- 80%
  ["discard_overlay_height"] = 0.80, -- 80%
}

UIManager = Class {
  init = function(self, toggles, constants)
    self.toggles = toggles
    self.constants = constants
  end;
  fromWidth = function(self, key)
    assert(key, "From width received nil key")
    assert(self.constants[key], "From width received key with value. key: "..key)
    return love.graphics.getWidth()*self.constants[key]
  end;
  fromHeight = function(self, key)
    assert(key, "From height received nil key")
    assert(self.constants[key], "From height received key with value. key: "..key)
    return love.graphics.getHeight()*self.constants[key]
  end;
  enable = function(self, key)
    assert(key, "Attempted to index UI manager toggles with nil key")
    assert(self.toggles[key] ~= nil, "Attempted to enable non-existent UI manager value: " .. key)
    self.toggles[key] = true
  end;
  disable = function(self, key)
    assert(key, "Attempted to index UI manager toggles with nil key")
    assert(self.toggles[key] ~= nil, "Attempted to disable non-existent UI manager value: " .. key)
    self.toggles[key] = false
  end;
}

return UIManager(toggles, constants)
