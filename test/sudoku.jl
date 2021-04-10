using Test
using JuMP
using Cbc
using Solutions

function test_sudoku_model()
    @info "Creating the sudoku model"
    model = sudoku_model()
    sudoku_fix_cells(model, [
        (1,2,6), (1,4,1), (1,6,4), (1,8,5), (2,3,8), (2,4,3), (2,6,5), (2,7,6),
        (3,1,2), (3,7,7), (4,1,8), (4,4,4), (4,6,7), (4,9,6), (5,3,6), (5,7,3),
        (6,1,7), (6,4,9), (6,6,1), (6,9,4), (7,1,5), (7,9,2), (8,3,7), (8,4,2),
        (8,6,6), (8,7,9), (9,2,4), (9,4,5), (9,6,8), (9,8,7)
    ])

    @info "Solving the sudoku"
    optimizer = optimizer_with_attributes(Cbc.Optimizer, "logLevel" => 0)
    set_optimizer(model, optimizer)
    optimize!(model)

    solution = [9 6 3 1 7 4 2 5 8;
                1 7 8 3 2 5 6 4 9;
                2 5 4 6 8 9 7 3 1;
                8 2 1 4 3 7 5 9 6;
                4 9 6 8 5 2 3 1 7;
                7 3 5 9 6 1 8 2 4;
                5 8 9 7 1 3 4 6 2;
                3 1 7 2 4 6 9 8 5;
                6 4 2 5 9 8 1 7 3]
    answer = sudoku_table(model)
    @info "Printing the result"
    @info answer
    @test answer == solution
end

@testset "sudoku.jl" begin
    test_sudoku_model()
end