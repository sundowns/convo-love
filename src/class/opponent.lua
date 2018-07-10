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
       self.qualities[v.name] = Quality(v.name, v.colour, 0)
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
    self.lastDialogue = self.currentDialogue
    local pool = {}
    for i, v in pairs(self.dialogue) do
      if self.dialogue[i]:evaluate(params) then
        table.insert(pool, self.dialogue[i])
      end
    end
    self.currentDialogue = pool[love.math.random(1,#pool)]
    -- Dont repeat dialogue unless there's only 1
    while self.currentDialogue == self.lastDialogue and #pool > 1 do
      self.currentDialogue = pool[love.math.random(1,#pool)]
    end
    self:speak(self.currentDialogue)
  end;
  initialDialogue = function(self, text)
    self.currentDialogue = Dialogue(text)
    self:speak(self.currentDialogue)
  end;
  update = function(self, dt)
    --TODO: update animation before this
    if self.anim.currFrame ~= self.anim.lastFrame then
      self:buildPortrait()
    end

    self.anim.lastFrame = self.anim.currFrame
  end;
  speak = function(self, dialogue)
    Moan.clearMessages()
    Moan.setSpeed(dialogue.text.speed)
    Moan.speak({"", {255,0,0}}, {dialogue.text.text}, {
      onstart=function()
      end,
      oncomplete=function()
      end
    })
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
