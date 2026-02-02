local standard_functions = {}

function standard_functions.memprint(n)
    print("memory:", n)
end

function standard_functions.wait(ms)
    os.execute("sleep " .. tonumber(ms) / 1000)
end

function standard_functions.add(x, y)
    return x + y
end

function standard_functions.sub(x, y)
    return x - y
end

function standard_functions.mul(x, y)
    return x * y
end

function standard_functions.div(x, y)
    return x / y
end

return standard_functions
