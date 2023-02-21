local TextScanner = {}
TextScanner.__index = TextScanner

function SplitString(str, delim)
  local tbl = {}
  for value in string.gmatch(str, "([^" .. delim .. "]+)") do
    table.insert(tbl, value)
  end
  return tbl
end

function TextScanner:new(text)
  local scanner = {}
  setmetatable(scanner, TextScanner)
  scanner.lines = SplitString(text, "\n")
  return scanner
end

function TextScanner:Get(key, index)
  index = index or 0
  for _, line in ipairs(self.lines) do
    local data = SplitString(line, "|")
    if data[1] == key then
      return data[2+index]
    end
  end
end

function TextScanner:Has(key)
  for _, line in ipairs(self.lines) do
    local data = SplitString(line, "|")
    if data[1] == key then
        return true
    end
  end
  return false
end

function TextScanner:Set(key, value, index)
  index = index or 0
  for i, line in ipairs(self.lines) do
    local data = SplitString(line, "|")
    if data[1] == key then
        data[2+index] = value
        
        local str = ""
        for _, value in ipairs(data) do
            if str:len() > 1 then
                str = str .. "|"
            end
            str = str .. value
        end
        self.lines[i] = str
        break
    end
  end
end

function TextScanner:Add(key, value)
  table.insert(self.lines, key .. "|" .. value)
end

function TextScanner:Print()
  local str = ""
  for _, line in ipairs(self.lines) do
    str = str .. line .. "\n"
  end
  return str
end

return TextScanner
