local cards = {}
cards.list = {
   ["Disagree"] = Card("Disagree"),
   ["Agree"] = Card("Agree"),
   ["Stall For Time"] = Card("Stall For Time")
}

-- Public
function cards.get(key)
   if cards.list[key] ~= nil then
      return cards.list[key]
   else
      assert(false, "Attempted to create card with nonexistent key: "..key)
   end
end

--https://stackoverflow.com/questions/22321277/randomly-select-a-key-from-a-table-in-lua#28006336
--^ Random selection function (basic, will expand based on a pool!)

return cards
