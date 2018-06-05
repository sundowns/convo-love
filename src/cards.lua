local cards = {}
cards.list = {}

function cards.clone(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[self.clone(orig_key)] = self.clone(orig_value)
        end
        setmetatable(copy, self.clone(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function cards.create(key)
   if cards.list[key] ~= nil then
      return cards.clone(cards.list[key])
   else
      assert(false, "Attempted to create card with nonexistent key: "..key)
   end
end

--google LUA modules, what am i doing wrong?
cards.list["Polite Compliment"] = new Card("Polite Compliment")
cards.list["Please/Thank you"] = new Card("Please/Thank you")
cards.list["Disagree"] = new Card("Disagree")
cards.list["Agree"] = new Card("Agree")
cards.list["Greeting"] = new Card("Greeting")
cards.list["Small Talk"] = new Card("Small Talk")
cards.list["Clever Riddle"] = new Card("Clever Riddle")

return cards
