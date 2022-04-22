using DtD
using Documenter

DocMeta.setdocmeta!(DtD, :DocTestSetup, :(using DtD); recursive=true)

makedocs(;
    modules=[DtD],
    authors="xKDR Forum",
    repo="https://github.com/xKDR/DtD.jl/blob/{commit}{path}#{line}",
    sitename="$DtD.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://xKDR.github.io/DtD.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/xKDR/DtD.jl",
    target = "build",
    devbranch="main"
)
