function slugVN(text)
    local diacriticsMap = {
        { base = 'a', regex = '[àáảãạăắằẵặẳâầấậẫẩ]' },
        { base = 'e', regex = '[èéẻẽẹêếềễệể]' },
        { base = 'i', regex = '[ìíỉĩị]' },
        { base = 'o', regex = '[òóỏõọôồốổỗộơờớởỡợ]' },
        { base = 'u', regex = '[ùúủũụưừứửữự]' },
        { base = 'y', regex = '[ỳýỷỹỵ]' },
        { base = 'd', regex = '[đ]' },
        { base = ' ', regex = '[%s]' }
    }

    local slug = text:lower()

    for _, diacritic in ipairs(diacriticsMap) do
        slug = slug:gsub(diacritic.regex, diacritic.base)
    end

    slug = slug:gsub('[%W_]+', '-') -- Remove any non-word characters
    slug = slug:gsub('[%s%-]+', '-') -- Replace whitespace and underscores with a single hyphen
    slug = slug:gsub('^%-+', '') -- Trim leading hyphens
    slug = slug:gsub('%-+$', '') -- Trim trailing hyphens

    return slug
end