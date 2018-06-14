-- Card names are to be defined in lower case with dashes separating words
local cards = {}
local CARDS_DIRECTORY = "src/cards/"
cards.list = {}

-- Public
function cards.get(key)
   if cards.list[key] ~= nil then
      return cards.list[key]
   else
      assert(false, "Attempted to create card with nonexistent key: "..key)
   end
end



local function init()
   local files = love.filesystem.getDirectoryItems(CARDS_DIRECTORY)
   for k, file in ipairs(files) do
      local size
      local name = Util.getLuaFileName(file)
      local loaded, size = love.filesystem.load(CARDS_DIRECTORY .. file)
      cards.list[name] = loaded()
   end
end

--https://stackoverflow.com/questions/22321277/randomly-select-a-key-from-a-table-in-lua#28006336
--^ Random selection function (basic, will expand)

init()
return cards
