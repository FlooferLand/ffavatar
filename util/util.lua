local util = {}

--- Makes a text task (for consistency and ease of use)
--- Attach it to a part that is inside a Camera group to billboard it
---@param part ModelPart
---@param id string
---@param text string
---@param scale? number
---@return TextTask
function util.makeText(part, id, text, scale)
    return part:newText(id)
			:text(text)
			:alignment("CENTER")
			:wrap(true)
			:scale(scale or 0.2)
			:backgroundColor(0, 0, 0, 0.3)
			:visible(false)
end

--- Calculate parent's values
--- - By 8-Bit Total
---@param part ModelPart
---@return Vector3 Position
---@return Vector3 Rotation
---@return Vector3 Scale
---@return Matrix4 PositionMatrix
function util.calcParentValues(part)
    local parent = part:getParent()
    if not parent then
        return part:getTruePos(), part:getTrueRot(), part:getTrueScale(), part:getPositionMatrix()
    end
    
    local pos, rot, scale, matrix = util.calcParentValues(parent)
    return 
        pos:add(part:getTruePos()),
        rot:add(part:getTrueRot()),
        scale:mul(part:getTrueScale()),
        matrix:add(part:getPositionMatrix())
end

--- Returns `true` if the table contains the value
---@param value any
---@param table table
---@return boolean
function util.valueInTable(value, table)
    local contains = false
	for i, v in ipairs(table) do
		if v == value then
			contains = true
			break
		end
	end
    return contains
end

--- DeepCopy by 4P5
---@param model ModelPart
---@param name string?
---@return ModelPart
function util.deepCopy(model, name)
    local copy = model:copy(name or model:getName())
    for _, child in pairs(copy:getChildren()) do
        copy:removeChild(child):addChild(util.deepCopy(child))
    end
    return copy
end

--- Walks through a table until it finds the value and retrieves it.
--- Essentially getting the value at a path like `myTable.parent.child.value` using strings as indexers instead of code
---@param table table
---@param path string[]
---@return string, any
function util.traverseTable(table, path)
    local value = table
    local stringPath = ""
    for _, key in ipairs(path) do
        value = value[key]  -- Traverse the table
        stringPath = stringPath .. ((#stringPath > 1 ) and "." or "") .. key
    end
    return value, stringPath
end

return util