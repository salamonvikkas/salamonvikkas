fullurl0 = req.get.link
if not fullurl0 or fullurl0 == "" then
    fullurl0 = "https://www.youtube.com/watch?v=vWGhEKJZ2yI"
end

-- Initialize necessary functions for plugins
local function checkExtension(one)
    extensions = {
        image = {'jpg', 'png', 'webp', 'psd', 'heic'},
        video = {'mp4', 'mkv', 'webm', 'flv', '3gp'},
        audio = {'mp3', 'mkv', 'm4a', 'flac', 'wav'},
        text = {'docx', 'doc', 'txt', 'md', 'odt'},
        word = {'docx', 'doc', 'odt'},
        excel = {'xls', 'xlsx'},
        powerpoint = {'ppt', 'pptx'},
        pdf = {'pdf'},
        archive = {'zip', 'rar', '7z', 'tar'},
        code = {'cpp', 'cs', 'php', 'html', 'js', 'py'},
        sql = {'sql'}
    }

    extension = one:match("[^.]+$")
    
    if extensions.image[extension] then
        return 'file-image-o'
    elseif extensions.video[extension] then
        return 'file-video-o'
    elseif extensions.audio[extension] then
        return 'file-audio-o'
    elseif extensions.text[extension] then
        return 'file-text-o'
    elseif extensions.word[extension] then
        return 'file-word-o'
    elseif extensions.excel[extension] then
        return 'file-excel-o'
    elseif extensions.powerpoint[extension] then
        return 'file-powerpoint-o'
    elseif extensions.pdf[extension] then
        return 'file-pdf-o'
    elseif extensions.archive[extension] then
        return 'file-archive-o'
    elseif extensions.code[extension] then
        return 'file-code-o'
    elseif extensions.sql[extension] then
        return 'database'
    else
        return 'file-o'
    end
end

local function get_youtube_id(url)
    local pattern = "(?:http(?:s)?://)?(?:www%.)(?:youtube%.com/watch%?v=|youtu%.be/)([%w_-]+)"
    local id = string.match(url, pattern)
    if not id then
        pattern = "[?&]v=([%w%-_]+)"
        id = string.match(url, pattern)
    end
    return id
end

local function render_youtube_iframe(url)
    local vidUrl = get_youtube_id(url)
    return "<iframe type=\"text/html\" allowfullscreen src=\"https://www.yout-ube.com/watch?v=" .. vidUrl .. "\"></iframe>"
end

local function render_dplayer(url)
    return string.format([[
        <div id="dplayer"></div>
        <script src="https://cdn.statically.io/gh/kn007/DPlayer-Lite/00dab19fc8021bdb072034c0415184a638a3e3b2/dist/DPlayer.min.js"></script>
        <script>
        const dp = new DPlayer({
            container: document.getElementById('dplayer'),
            video: {
                url: '%s',
            },
        });
        </script>
    ]], url)
end

local function render_noembed(url)
    return string.format([[
        <div id="place"></div>
        <script>
        fetch("https://noembed.com/embed?url=%s")
        .then(x => x.json())
        .then(y => {
            document.getElementById("place").innerHTML = y.html;
            console.log(y.html);
        });
        </script>
    ]], url)
end

local function render_content(fullurl)
    if string.find(string.lower(fullurl), 'youtube') or string.find(string.lower(fullurl), 'youtu.be/') then
        return render_youtube_iframe(fullurl)
    elseif checkExtension(fullurl) == 'file-audio-o' or checkExtension(fullurl) == 'file-video-o' then
        return render_dplayer(fullurl)
    else
        return render_noembed(fullurl)
    end
end

print([[<style>html,body{margin:0;height:100%;overflow:hidden}iframe{width:100%;height:100%;border:none}</style>]])
print(render_content(fullurl0))