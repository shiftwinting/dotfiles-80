local map = require "mapper"

map.nplug(']i', 'dial-increment')
map.nplug('[i', 'dial-decrement')

map.vplug(']i', 'dial-increment')
map.vplug('[i', 'dial-decrement')

local dial = require("dial")

local enum_cyclic = function(name, ptnlst)
    local ptn_format = "\\C\\M\\<\\(%s\\)\\>"
    local vim_regex_ptn = string.format(ptn_format, table.concat(ptnlst, "\\|"))

    local function find(cursor, line)
        local idx_start = 1

        while idx_start <= #line do
            local match = vim.fn.matchstrpos(line, vim_regex_ptn, idx_start)
            if match[2] == -1 then break end
            local s = match[2] + 1
            local e = match[3]

            if (cursor <= e) then
                return {from = s, to = e}
            else
                idx_start = e + 1
            end
        end
        return nil
    end

    local function add(cursor, text, addend)
        local n_ptnlst = #ptnlst
        local n = 1
        for i, ptn in pairs(ptnlst) do
            if text:find(ptn) ~= nil then n = i end
        end
        n = (n + addend - 1) % n_ptnlst + 1
        text = ptnlst[n]
        cursor = #text
        return cursor, text
    end

    return {name = name, desc = vim_regex_ptn, find = find, add = add}
end

local my_augends = {
    dial.augends.number.decimal, dial.augends.number.hex,
    dial.augends.number.binary, dial.augends.date.date,
    dial.augends.markup.markdown_header,
    enum_cyclic("bool.lower", {"true", "false"}),
    enum_cyclic("bool.upper", {"True", "False"}),
    enum_cyclic("yn.lower", {"yes", "no"}),
    enum_cyclic("yn.upper", {"Yes", "No"}),
    enum_cyclic("yn.capital.lower", {"y", "n"}),
    enum_cyclic("yn.capital.upper", {"Y", "N"})
}

dial.searchlist.normal = my_augends
dial.searchlist.visual = my_augends
