local creds = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://tin-secretive-tractor.glitch.me/credits"))
local hm = creds["Honorable Mentions"]
local hmt = [[Honorable Mentions:
]]
for i,o in pairs(hm) do
 hmt = hmt..i.." "..o..[[.
]]
end
local po = creds["Purpul Owners"]
local pot = [[Purpul Team:
]]
pot = pot..po[1].." & "..po[2]..[[ 
]]
local wt = [[Developer:
]]..creds["VV4FR Unzip API Creator/Dev"]
local printable = [[CREDITS:
]]..hmt..pot..wt
print(printable)
function to_base64(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end
function from_base64(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end
local request = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request or function(tabl)
    warn("An error has occurred, check error.txt in your workspace folder")
    return game:GetService("HttpService"):JSONEncode({["error.txt"]="Bro, you can't even make requests.."})
end
local zipFile = game:HttpGetAsync("https://github.com/kaithub/purpul-questionmark/raw/main/new_purpul.zip")
Response = request({
    Url = "https://tin-secretive-tractor.glitch.me/unzip",
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/octet-stream"
    },
    Body = to_base64(zipFile)
})
if Response.Success then
    for i, o in pairs(game:GetService("HttpService"):JSONDecode(Response.Body)) do
        writefile(i, o)
    end
else
    warn("Request failed with status code: " .. Response.StatusCode)
end
