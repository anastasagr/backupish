local lfs = require("lfs")


/**
    INITIAL SETTINGS AND VALUES
**/
local sourcePath = "/source" 
local backupPath = "/backups"
local backupInterval = 3600  

local lastSize = 0


local function copyFile(src, dest)
    local inputFile = io.open(src, "rb")
    local outputFile = io.open(dest, "wb")

    if inputFile and outputFile then
        local content = inputFile:read("*a")
        outputFile:write(content)
        inputFile:close()
        outputFile:close()
        return true
    else
        return false
    end
end



local function checkAndBackup()
    local attr = lfs.attributes(sourcePath)

    if attr and attr.size ~= lastSize then
       
        local success = copyFile(sourcePath, backupPath .. "/backup_" .. os.date("%Y%m%d%H%M%S") .. ".bak")
        if success then
            print("Backup file created:", os.date())
            lastSize = attr.size
        else
            print("something went wrong!!")
        end
    else
        print("No changes to file. Backup aborted!!")
    end
end


while true do
    checkAndBackup()
    os.execute("sleep " .. backupInterval)
end