--[[
   util.lua - Authored by Thomas Smallridge (sundowns)
   Handly module containing various handy functions for game development in lua,
   particularly with Love2D.
]]

--TODO: Modularise this before it gets massive (filesystem, maths, debug, etc)

local util = {}
util.love = {}

function util.roundToNthDecimal(num, n)
  local mult = 10^(n or 0)
  return math.floor(num * mult + 0.5) / mult
end

function util.printTable(table, name)
  print("==================")
  if name then print("Printing table: " .. name) end
  for k, v in pairs(table) do
    if type(v) == "table" then
      print("[table]: " .. tostring(k))
      for key, val in pairs(v) do
        print(" *[key]: " .. tostring(key) .. " | [value]: " .. tostring(val))
      end
    else
      print("[key]: " .. tostring(k) .. " | [value]: " .. tostring(v))
    end
  end
end

function util.concatTables(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

function util.withinVariance(val1, val2, variance)
  local diff = math.abs(val1 - val2)
  if diff < variance then
    return true
  else
    return false
  end
end

function util.clamp(val, min, max)
    if min - val > 0 then
        return min
    end
    if max - val < 0 then
        return max
    end
    return val
end

function util.log(text)
    if debug then
        print(text)
    end
end

function util.fileExists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function util.getLuaFileName(url)
   return string.gsub(url, ".lua", "")
end

function util.love.resetColour()
   love.graphics.setColor(255,255,255,255)
end

function util.love.renderStats()
   local stats = love.graphics.getStats()
   love.graphics.print("texture memory (MB): ".. stats.texturememory / 1024 / 1024, 3, 60)
   love.graphics.print("drawcalls: ".. stats.drawcalls, 3, 80)
   love.graphics.print("canvasswitches: ".. stats.canvasswitches , 3, 100)
   love.graphics.print("images loaded: ".. stats.images, 3, 120)
   love.graphics.print("canvases loaded: ".. stats.canvases, 3, 140)
   love.graphics.print("fonts loaded: ".. stats.fonts, 3, 160)
end

return util
