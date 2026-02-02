local standard_functions = {}

function standard_functions.memprint(n)
    print("memory:", n)
end

function standard_functions.wait(ms)
    os.execute("sleep " .. tonumber(ms) / 1000)
end

return standard_functions
