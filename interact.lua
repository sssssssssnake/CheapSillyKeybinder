

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

::start::

-- Call the interact function and store its return value
local responsable = interact()

if responsable == nil then
    print("No response from port")
    -- clear the console
    os.execute("cls")
    goto start    
end
-- remove any leading or trailing whitespace
responsable = responsable:gsub("^%s*(.-)%s*$", "%1")
print("KEYWORD: " .. responsable)



if responsable == "PURPLE" then  -- Note that we compare with "NOCHANGE" instead of "PURPLE\n"
    print("Opening Rick Astley video")
    os.execute("start https://www.youtube.com/watch?v=dQw4w9WgXcQ")
end
print("\"" .. "test" .. "\"")