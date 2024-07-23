local interp = {}

--- Applies basic linear interpolation
---@param a number
---@param b number
---@param t number
---@return number
function interp.basic(a, b, t)
    return a + (b - a) * t
end

--- Applies ease interpolation
---@param a number
---@param b number
---@param t number
---@return number
function interp.easeIn(a, b, t)
    t = t * t
    return a + (b - a) * t
end

--- Applies ease interpolation
---@param a number
---@param b number
---@param t number
---@return number
function interp.easeOut(a, b, t)
    t = 1 - (1 - t) * (1 - t)
    return a + (b - a) * t
end

--- Applies ease interpolation
---@param a number
---@param b number
---@param t number
---@return number
function interp.easeInOut(a, b, t)
    t = t * t * (3 - 2 * t)
    return a + (b - a) * t
end

--- Applies bouncy interpolation
---@param a number
---@param b number
---@param t number
---@return number
function interp.bouncy(a, b, t)
    local n1 = 7.5625
    local d1 = 2.75

    if t < 1 / d1 then
        return a + (b - a) * (n1 * t * t)
    elseif t < 2 / d1 then
        t = t - 1.5 / d1
        return a + (b - a) * (n1 * t * t + 0.75)
    elseif t < 2.5 / d1 then
        t = t - 2.25 / d1
        return a + (b - a) * (n1 * t * t + 0.9375)
    else
        t = t - 2.625 / d1
        return a + (b - a) * (n1 * t * t + 0.984375)
    end
end


return interp
