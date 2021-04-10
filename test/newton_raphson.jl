using Test
using LinearAlgebra

function test_newton_raphson()
    f(x) = [x[1]^2 + x[2]^2 - 4*x[3] - 0;
            x[1]^2 + x[3]^2 + 0*x[3] - (1/4);
            x[1]^2 + x[2]^2 + x[3]^2 - 1]
    x0 = [1.0, 1.0, 1.0]
    ϵ = 0.001
    x = newton_raphson(f, x0, ϵ)
    @test isapprox(norm(f(x[end])), 0; atol=ϵ)
end

@testset "newton_raphson.jl" begin
    test_newton_raphson()
end
