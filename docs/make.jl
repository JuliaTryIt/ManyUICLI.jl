using Documenter
using ManyUICLI

makedocs(
    sitename = "ManyUICLI.jl",
    format = Documenter.HTML(),
    modules = [ManyUICLI]
)

deploydocs(
    repo = "github.com/s-celles/ManyUICLI.jl.git",
)
