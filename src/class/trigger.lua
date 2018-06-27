Trigger = Class {
  init = function(self, operator, value, result)
    assert(operator == ">" or operator == "=" or operator == "<")
    self.value = value
    self.operator = operator
    self.result = result
  end;
}

QualityTrigger = Class {_includes=Trigger,
  init = function(self, quality, operator, value, result)
    Trigger.init(self, operator, value, result)
    assert(quality)
    self.quality = quality
  end;
  evaluate = function(self, params)
    assert(params.opponent.qualities)
    local triggered = false
    if self.operator == ">" then
      triggered = params.opponent.qualities[self.quality].value > self.value
    elseif self.operator == "=" then
      triggered = params.opponent.qualities[self.quality].value == self.value
    elseif self.operator == "<" then
      triggered = params.opponent.qualities[self.quality].value < self.value
    end

    if triggered then
      return {
        result = self.result,
        quality = self.quality
      }
    end
  end;
}

TurnCountTrigger = Class {_includes=Trigger,
  init = function(self, operator, value, result)
    Trigger.init(self, operator, value, result)
  end;
  evaluate = function(self, params)
    assert(params.turn.turnCount)
    local triggered = false
    if self.operator == ">" then
      triggered = params.turn.turnCount > self.value
    elseif self.operator == "=" then
      triggered = params.turn.turnCount == self.value
    elseif self.operator == "<" then
      triggered = params.turn.turnCount < self.value
    end

    if triggered then
      return {
        result = self.result
      }
    end
  end;
}
