-- trait names are to be defined in lower case with dashes separating words
local traits = {}
local TRAITS_DIRECTORY = "src/traits/"
traits.list = {}

-- Our 'traits' are actually just references to their single definitions in the main table
function traits.get(key)
   if traits.list[key] ~= nil then
      return traits.list[key]
   else
      assert(false, "Attempted to create trait with nonexistent key: "..key)
   end
end

local function init()
   local files = love.filesystem.getDirectoryItems(TRAITS_DIRECTORY)
   for k, file in ipairs(files) do
      local size
      local name = Util.f.getLuaFileName(file)
      local loaded, size = love.filesystem.load(TRAITS_DIRECTORY .. file)
      traits.list[name] = loaded()
   end
end

init()
return traits
