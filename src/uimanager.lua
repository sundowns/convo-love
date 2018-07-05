local toggles = {
  ["show_deck"] = false,
  ["show_used"] = false,
  ["overlay_active"] = false
}

local values = {
  ["deck_items_per_row"] = 5
}

UIManager = Class {
  init = function(self, toggles, values)
    self.toggles = toggles
    self.values = values
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

return UIManager(toggles, values)
