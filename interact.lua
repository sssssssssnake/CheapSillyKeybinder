local function pingPort(message)
    print("Pinging port with message: " .. message)
    
    local comPort = "COM3"
    local baud = "115200"
    local dataToWrite = message

    --run the powershell script with supplied params. Spaces are important.
    print("Running powershell script with params: " .. comPort .. " " .. baud .. " " .. dataToWrite)
    os.execute("pwsh.exe -File ./runToFile.ps1 "..comPort.. " " .. baud .. " " .. dataToWrite)
    print("Powershell script executed")

    print("Pinged port")

    local file = io.open(".\\responses.txt", "r")
    print("Opened file")
    print(file)
    if not file then
        print("File not found")
        return "File not found"
    end
    local rslt = file:read("*L")

    local resultLines = {}
    for line in file:lines() do
        -- Split the line at ": "
        local parts = {line:match("(.-):%s*(.+)")}
        if #parts == 2 then
            -- Extract and store the text after ": "
            table.insert(resultLines, parts[2])
        end
    end

    file:close()

    return table.concat(resultLines, "\n")

end
local function interact()
    print("Interacting with port (Interact call)")
    local message = "Hello from Lua"
    local response = pingPort(message)
    responseLine = splitString(response, "\n")[1]
    print("Response: " .. type(responseLine))
    return responseLine
end

function splitString(inputstr, sep)
    if (sep == nil) then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end


DebugFile = io.open(".\\debugLua.txt", "a")
local isDebugOpen = true
local function debugLog(message)
    if not isDebugOpen then
        DebugFile = io.open(".\\debugLua.txt", "a")
        isDebugOpen = true
    end
    DebugFile:write(message)
    DebugFile:write("\n")
    DebugFile:close()
    isDebugOpen = false
end
local lastResponse = nil
::start::

-- Call the interact function and store its return value
local responsable = interact()
print("called interact")

print(responsable)

-- If the response is nil, print an error message and go back to the start
if responsable == nil then
    print("No response from port")
    -- clear the console
    -- os.execute("cls")
    debugLog("got nil response")
    lastResponse = "nil"
    goto start    
end

-- remove any leading or trailing whitespace
responsable = responsable:gsub("^%s*(.-)%s*$", "%1")

debugLog("Response: " .. responsable)


-- If the response is the same as the last response, print an error message and go back to the start
if responsable == lastResponse then
    print("Same response as last time")
    debugLog("Same response as last time")
    -- clear the console
    os.execute("cls")
    goto start
end


print("KEYWORD: " .. responsable)



if responsable == "PURPLE" then
    print("Opening Rick Astley video")
    os.execute("start https://www.youtube.com/watch?v=dQw4w9WgXcQ")
    os.execute("cls")
    debugLog("Rickrolled")
    lastResponse = "PURPLE"
    goto start
end

-- If the response is "NOCHANGE", print a message and go back to the start
if responsable == "NOCHANGE" then
    print("No change")
    os.execute("pwsh.exe ./keybinds.ps1" .. " NOCHANGE as this is the way, idk if there is anything else")
    debugLog("No change")
    lastResponse = "NOCHANGE"
    goto start
end

-- If the response is "GREEN", ping spotify to play "Never Been Better" by half•alive
if responsable == "GREEN" then
    print("Playing Never Been Better by half•alive")
    os.execute("taskkill /im spotify.exe")
    os.execute("start spotify:track:0Roz3ERK1OvRrqSxpt201d")
    os.execute("cls")
    debugLog("Playing All Star")
    lastResponse = "GREEN"
    goto start
end

if responsable == "BLUE" then
    -- mute discord
    print("Muting Discord")
    
end