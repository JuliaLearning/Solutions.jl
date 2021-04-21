using Test
using Solutions

@info "Testing sudoku.jl"
@testset "sudoku.jl" begin
    test_sudoku_model()
end

@info "Testing newton_raphson.jl"
@testset "newton_raphson.jl" begin
    test_newton_raphson()
end
