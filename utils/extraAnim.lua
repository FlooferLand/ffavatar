local extraAnim = {}

--- Allows for stacked animations
function extraAnim.createPartAnimAdder()
    local function base()  --- To constantly apply
        return {
            scale = vec(1, 1, 1),
            rot = vec(0, 0, 0)
		}
    end
    local function default()
        return {
            scale = vec(0, 0, 0),
            rot = vec(0, 0, 0)
		}
    end

	local animAdder = {
        __content = {},

		--- @param self table
		--- @return table
        get = function(self)
            return self.__content
        end,

		--- @param self table
		--- @param input table
		add = function(self, input)
			local result = default()
            for k, v in pairs(input) do
                result[k] = v
            end
			table.insert(self.__content, result)
		end,

		--- @param self table
		--- @param x number
		--- @param y number
		--- @param z number
		addScale = function(self, x, y, z)
			self:add({ scale = vec(x, y, z) })
		end,

		--- @param self table
		--- @param x number
		--- @param y number
		--- @param z number
		addRot = function(self, x, y, z)
			self:add({ rot = vec(x, y, z) })
		end
	}

    table.insert(animAdder.__content, base())
    return animAdder
end

return extraAnim
