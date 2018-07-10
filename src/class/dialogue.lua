-- Implement contextuality here somehow
textSpeeds = {
  ["xxslow"] = 0.16,
  ["xslow"] = 0.12,
  ["slow"] = 0.08,
  ["medium"] = 0.04,
  ["fast"] = 0.01,
  ["xfast"] = 0.015,
  ["xxfast"] = 0.02
}

Dialogue = Class {
  --[[ Parameters:
    + text (string): Dialogue text. If provided, will be initialised at medium speed
    + text (table): Table with dialogue text and provided speed. Should include 'text' and 'speed' values
    + triggers (table): Table of Triggers
  ]]
  init = function(self, text, triggers)
    if type(text) == "table" then
      assert(tostring(text.text), "Dialogue() - Received non-string text value")
      if tostring(text.speed) then
        text.speed = textSpeeds[text.speed]
      end
      if not text.speed then
        text.speed = textSpeeds.medium
      end
      self.text = text
    elseif type(text) == "string" then
      self.text = {
        text = text,
        speed = textSpeeds["medium"]
      }
    else
      assert(tostring(text), "Dialogue() - Expected text as string, got " .. tostring(text))
      print(type(text))
    end
    self.triggers = triggers or {}
  end;
  -- return true => to INCLUDE in dialogue pool
  -- return false => to EXCLUDE from dialogue pool
  -- At the moment we are evaluating if ALL triggers are true
  evaluate = function(self, params)
    if #self.triggers == 0 then
      return true
    end
    local triggered = true
    for i, trigger in ipairs(self.triggers) do
      local result = trigger:evaluate(params)
      if not result then
        triggered = false
      end
    end
    return triggered
  end;
}
