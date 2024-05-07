local util = require "scripts.ffavatar.utils.util"
local actionWheelUtil = {}

--- Makes a new config page
---@return Page
function actionWheelUtil.configMakeSubpage()
    local page = action_wheel:newPage()
    page:newAction()
        :item("minecraft:string")
        :title("go back")
        :onLeftClick(function()
            action_wheel:setPage(ActionWheelPages.Main)
        end)
        :color(0.25, 0, 0)
    return page
end

--- Makes a new config action/setting
---@param item ItemStack|Minecraft.itemID
---@param title string
---@param configPath string[]
---@param configOnPress function
function actionWheelUtil.configMakeAction(item, title, configPath, configOnPress)
    -- Safety first
    for i, str in pairs(configPath) do
        if str:find("%.") ~= nil then
            error(string.format("config action \"%s\" contained a dot instead of a comma during config action creation!\nThat is a mistake!", str))
        end
    end

    -- Creating everything
    local configValue, configStringPath = util.traverseTable(AvatarConfig, configPath)
    ConfigPageActions[configStringPath] =
        ActionWheelPages.Config:newAction()
        :item(item)
        :title(string.format("%s [%s=%s]", title, configStringPath, tostring(configValue)))
        :onLeftClick(function()
            configOnPress()
            AvatarConfig:save()
            action_wheel:setPage(ActionWheelPages.Main)
        end)
end

--- DANCIN
--- TODO: FIXME: This won't sync correctly! Use Sync Pings to check since it forces backend pings
---@param animName string
function pings.flipDanceAnimation(animName)
    sounds:playSound("minecraft:item.dye.use",player:getPos(),0.5,1,false)

    local pageContent = DancePageContent[animName]
    local anim = pageContent.anim
    local action = pageContent.action
    local item = pageContent.defaultItem
    local sound = pageContent.sound
    if not util.valueInTable(anim, animations:getPlaying()) then
        animations:stopAll()
        anim:play()
        action:setItem("minecraft:lime_wool")
        Dancing = pageContent
        if sound ~= nil then
            sounds:playSound(sound, player:getPos(), nil, nil, true)
        end
    else
        anim:stop()
        action:setItem(item)
        Dancing = nil
        if sound ~= nil then
            sounds:stopSound(sound)
        end
    end
end

--- Makes a new config action/setting
---@param item ItemStack|Minecraft.itemID
---@param title string
---@param anim Animation
---@param sound string|nil
function actionWheelUtil.danceMakeAction(item, title, anim, sound)
    local action = ActionWheelPages.Dances:newAction()
        :item(item)
        :title(title)

    local animName = anim.name
    action:setOnLeftClick(function()
        pings.flipDanceAnimation(animName)
    end)
    DancePageContent[animName] = {
        anim = anim,
        action = action,
        defaultItem = item,
        sound = sound
    }
end

return actionWheelUtil