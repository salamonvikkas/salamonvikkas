function smile(input_string)
    local arrEmoName = {'ami', 'anya', 'aru', 'aka', 'dauhanh', 'dora', 'le', 'menhera', 'moew', 'nam', 'pepe', 'qoobee', 'qoopepe', 'thobaymau', 'troll', 'dui', 'firefox', 'conan'}

    for _, emoName in ipairs(arrEmoName) do
        local pattern = ":" .. emoName .. "([0-9]*):"
        local replacement = '<img loading="lazy" src="https://moleys.github.io/assets/images/' .. emoName .. '/' .. emoName .. '%1.png" alt="%1"/>'
        input_string = input_string:gsub(pattern, replacement)
    end

    return input_string
end
function bb_simple(input_string)
    local bbcode_rules = {
        { pattern = '%[b%](.-)%[/b%]', replacement = '<strong>%1</strong>' },
        { pattern = '%[i%](.-)%[/i%]', replacement = '<em>%1</em>' },
        { pattern = '%[u%](.-)%[/u%]', replacement = '<u>%1</u>' },
        { pattern = '%[s%](.-)%[/s%]', replacement = '<s>%1</s>' },
        { pattern = '%[url=(.-)%](.-)%[/url%]', replacement = '<a href="%1">%2</a>' },
        { pattern = '%[img%](.-)%[/img%]', replacement = '<img src="%1" />' },
        -- Add more rules for other BBCode tags as needed
    }

    for _, rule in ipairs(bbcode_rules) do
        input_string = input_string:gsub(rule.pattern, rule.replacement)
    end

    return input_string
end
function bbcode(nd)
    nd = nd:gsub('(\r\n|\r|\n)', '<br>')
    nd = smile(nd)
    nd = bb_simple(nd)
    return nd
end
print(bbcode("[b]vikkas[/b] :ami1:"))