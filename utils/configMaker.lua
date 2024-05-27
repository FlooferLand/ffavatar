local util = require "scripts.ffavatar.utils.util"
local configMaker = {}

--- Syncs the config from the host to the clients
function pings.loadConfig(hostConfig)
    local save = AvatarConfig.save
    local load = AvatarConfig.load

    AvatarConfig = hostConfig
    AvatarConfig["save"] = save
    AvatarConfig["load"] = load
end

--- Adds the "save" and "load" methods and other stuff to an Avatar Config
function configMaker.avatarConfigInit()
    local configCore = {
        ---@diagnostic disable: assign-type-mismatch, param-type-mismatch
        save = function()
            if not host:isHost() then return end

            for k, v in pairs(AvatarConfig) do
                if k ~= "save" and k ~= "load" then
                    config:save(k, v)
                end
            end
        end,

        ---@diagnostic disable: assign-type-mismatch, param-type-mismatch
        load = function()
            if not host:isHost() then
                return
            end

            for k, v in pairs(config:load()) do
                if k ~= "save" and k ~= "load" then
                    AvatarConfig[k] = v
                end
            end
            pings.loadConfig(AvatarConfig)
        end
    }

    AvatarConfig = util.concatTables(AvatarConfig, configCore)
end

return configMaker
