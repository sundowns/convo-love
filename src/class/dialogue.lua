-- Implement contextuality here somehow
Dialogue = Class {
  init = function(self, text, triggers)
    self.text = text
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
