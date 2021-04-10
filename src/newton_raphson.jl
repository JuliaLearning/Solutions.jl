using LinearAlgebra
using ForwardDiff

export newton_raphson

∇(f, x) = ForwardDiff.jacobian(f, x)

function newton_raphson(f::Function, x0::Vector{Float64}, ϵ::Float64)
    xs = [x0]
    d = inv(-∇(f, x0)) * f(x0)
    while norm(d) > ϵ
        x = xs[end] + d
        d = inv(-∇(f, x)) * f(x)
        push!(xs, x)
    end
    return xs
end
