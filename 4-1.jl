using Plots
using LaTeXStrings
pgfplotsx()

colors =  [:red,:green,:blue,:magenta,:black,:yellow,:cyan]
x = range(0,stop=2π, length=1000)
f(x, n) = sin(n*x)/x

plot()
for i in 1:5
   plot!(x,f.(x, i), c=colors[i], label = latexstring("\\frac{\\sin($i x)}{x}"))
end
Plots.gui()
