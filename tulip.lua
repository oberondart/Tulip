-- Sparkle scripting language
standard_functions = require 'standardlib'

local filename = arg[1]
if not filename then
    print("Usage: tulip <script.spark>")
    return
end

local lcount = 0
local varstorage = {}

for line in io.lines(filename) do
    lcount = lcount + 1

    -- variable definitions
    for key, value in line:gmatch("<(.-)>%[([^%]]+)%]") do
        varstorage[key] = value
    end

    -- quoted words
    for word in line:gmatch("'(.-)'") do
        print(varstorage[word] or word)
    end

    -- variable usage
    for out in line:gmatch("&(.-)&") do
        if out == "" then
            error("error on line " .. lcount .. ": empty variable reference")
        end
        if not varstorage[out] then
            error("error on line " .. lcount .. ": variable " .. out .. " does not exist")
        end
        print(varstorage[out])
    end

    -- function calls
    for func, param in line:gmatch("!(.-)!([%d%a]+)") do
        if func == "memprint" then
            standard_functions.memprint(tonumber(param))
        elseif func == "wait" then
            standard_functions.wait(tonumber(param))
        end
    end
end
