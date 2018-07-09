Opponent = Class {
  init = function(self, name, assetsPath)
    self.name = name
    self.assetsPath = assetsPath
    self.anim = {}
    self.anim.currState = "base"
    self.anim.currFrame = 0
    self.anim.lastFrame = nil
    self.anim.image = nil
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
    if self.currentDialogue then
      love.graphics.setColor(1,0,0)
      love.graphics.print(self.currentDialogue.text, x, y+450)
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
    Moan.clearMessages()
    Moan.speak({"", {255,0,0}}, {self.currentDialogue.text}, {x=10,y=10})
  end;
  initialDialogue = function(self, text)
    self.currentDialogue = Dialogue(text)
    Moan.speak({"", {255,0,0}}, {self.currentDialogue.text}, {x=200,y=200})
  end;
  update = function(self, dt)
    --TODO: update animation before this
    if self.anim.currFrame ~= self.anim.lastFrame then
      self:buildPortrait()
    end

    self.anim.lastFrame = self.anim.currFrame
  end;
  buildPortrait = function(self)
    local canvas = love.graphics.newCanvas(constants.PORTRAIT.WIDTH, constants.PORTRAIT.HEIGHT)
    love.graphics.setCanvas(canvas)
      Util.love.resetColour()
      love.graphics.draw(Assets.opponents.frame, 0, 0)
      love.graphics.draw(Assets[self.assetsPath][self.anim.currState..'-'..self.anim.currFrame], 0, 0)
      -- TODO: draw the current frame on top
    love.graphics.setCanvas()
    self.anim.image = love.graphics.newImage(canvas:newImageData())
  end;
}
