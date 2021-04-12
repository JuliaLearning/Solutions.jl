using Test
using Solutions

@testset "sudoku.jl" begin
    test_sudoku_model()
end

@testset "newton_raphson.jl" begin
    test_newton_raphson()
end
