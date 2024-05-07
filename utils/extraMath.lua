--- ExtraMath by FlooferLand
local extraMath = {}

---Should've used sun screen
---@param y number
---@param x number
---@return number
function extraMath.atan_deg(y, x)
    return math.deg(math.atan(y, x))
end

---
function extraMath.hypotenuse(x, y)
    return math.sqrt(x^2 + y^2)
end

--- Points towards a position
--- @param obj_pos Vector3
--- @param target_pos Vector3
--- @return Vector3 obj_rotation
function extraMath.pointTowards(obj_pos, target_pos)
    local direction_vec = (target_pos - obj_pos):normalize()
    local yaw = math.atan2(direction_vec.y, direction_vec.x)
    local pitch = math.asin(-direction_vec.z)
    return vec(yaw, pitch, 0)  -- No roll for now
end

---WoOoOoOooOo (sin/cos by time)
---@param frequency number
---@param edge_clamp number
---@return number
function extraMath.wave(frequency, edge_clamp)
    return (1.0 - edge_clamp) + (math.sin(client.getSystemTime() * (frequency * 0.1)) * edge_clamp)
end

---@param rotation Vector3
---@param position Vector3
---@return Vector3
function extraMath.getUpVector(rotation, position)
    local forward = rotation * vec(0, 0, 1)  -- Assuming rotation is a transformation matrix applied to (0, 0, 1)
    local side = forward:cross(vec(0, 1, 0))  -- Cross product of forward and world up vector
    local up = side:cross(forward)  -- Cross product of side and forward
    return up:normalize()
end

---@param bool boolean
---@return integer
function extraMath.boolToInt(bool)
    return bool and 1 or 0
end

---@param a Vector3
---@param b Vector3
---@param delta number
function extraMath.vectorLerp(a, b, delta)
    return vec(
        math.lerp(a.x, b.x, delta),
        math.lerp(a.y, b.y, delta),
        math.lerp(a.z, b.z, delta)
    )
end

return extraMath
