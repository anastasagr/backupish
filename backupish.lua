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