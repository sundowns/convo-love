Opponent = Class {
  init = function(self, name, assetsPath)
    self.name = name
    self.assetsPath = assetsPath
    self.anim = {}
    self.anim.currState = "base"
    self.anim.currFrame = 0
    self.dialogue = {}
    self.qualities = {}
    self.currentDialogue = nil
    self.traits = {}
    for i,v in ipairs(constants.QUALITIES) do
       self.qualities[v] = Quality(v, 0)
    end
  end;
  --x and y origins to render relative to
  render = function(self, x, y)
    local count = 0
    love.graphics.setColor(1,1,1)
    love.graphics.print(self.name, x, y)
    if self.currentDialogue then
      love.graphics.setColor(1,0,0)
      love.graphics.print(self.currentDialogue.text, x, y+220)
    end
    if self.assetsPath then
      Util.l.resetColour()
      love.graphics.draw(Assets.opponents.frame, x, y+20, 0, 3, 3)
      love.graphics.draw(Assets[self.assetsPath][self.anim.currState..'-'..self.anim.currFrame], x, y, 0, 3, 3)
    end
  end;
  applyQualityDeltas = function(self, deltas)
    for k,v in pairs(self.qualities) do
      if deltas[k] ~= 0 then
        self.qualities[k]:updateBy(deltas[k])
      end
    end
  end;
  selectDialogue = function(self, params)
    --TODO: Need some advanced method to prevent REPEATING dialogue (UNLESS its the ONLY option???)
    local pool = {}
    for i, v in pairs(self.dialogue) do
      if self.dialogue[i]:evaluate(params) then
        table.insert(pool, self.dialogue[i])
      end
    end
    self.currentDialogue = pool[love.math.random(1,#pool)]
  end;
}
