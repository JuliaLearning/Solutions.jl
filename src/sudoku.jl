using JuMP

export sudoku_model
export sudoku_fix_cells
export sudoku_table

const I = 1:9
const J = 1:9
const K = 1:9

function sudoku_model()
    model = Model()
    @variable(model, x[I, J, K], Bin)
    @constraint(model, [i in I, j in J], sum(x[i, j, k] for k in K) == 1)
    @constraint(model, [j in J, k in K], sum(x[i, j, k] for i in I) == 1)
    @constraint(model, [i in I, k in K], sum(x[i, j, k] for j in J) == 1)
    @constraint(model, [k in K, m in 1:3, n in 1:3],
        sum(sum(x[i, j, k] for j in (3m-2):(3m)) for i in (3n-2):3n) == 1)
    @objective(model, Min, 1)
    return model
end

function sudoku_fix_cells(model, fixed::Array{NTuple{3, Int}})
    x = model[:x]
    @constraint(model, [(i, j, k) in fixed], x[i, j, k] == 1)
end

function sudoku_table(model)
    x_value = value.(model[:x])
    return [findmax(collect(x_value[i, j, :]))[2] for i in I, j in J]
end
