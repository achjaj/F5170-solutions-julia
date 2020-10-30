using DifferentialEquations
using LinearAlgebra
using Plots

plotlyjs()

p = [1.67e-27, 1.60e-19, 3.12e-5, 1.0] # [m, q, B₀, y₀]

r₀ = [0.0, p[4], 0.0]
dr₀ = sqrt(2)*[1.0, 1.0, 0.0]

tspan = (0.0, 10.0)

function equation!(ddu, du, u, p, t)
    B = [0.0, 0.0, p[3]*(u[2]/p[4])^2]

    ddu .= (p[2]/p[1])*(du × B)
end

problem = SecondOrderODEProblem(equation!, dr₀, r₀, tspan, p)
sol = solve(problem, Rosenbrock23())

t = range(tspan[1], length = 500, stop = tspan[2])
r = [(x, y) for (dx, dy, dz, x, y, z) in sol(t)]
v = [(dx, dy, dz) for (dx, dy, dz, x, y, z) in sol(t)]
plot(r, markersize = 0.5)
scatter(v, markersize = 0.1)

plt = plot(1, xlims = (-0.006, 0.0), ylims = (0.999, 1.0))
@gif for (dx, dy, dz, x, y, z) in sol(t)
    push!(plt, x, y)
end every 1
