using MertonDtD
using Documenter

DocMeta.setdocmeta!(MertonDtD, :DocTestSetup, :(using MertonDtD); recursive=true)

makedocs(;
    modules=[MertonDtD],
    authors="xKDR Forum",
    repo="https://github.com/xKDR/MertonDtD.jl/blob/{commit}{path}#{line}",
    sitename="$MertonDtD.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://xKDR.github.io/MertonDtD.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/xKDR/MertonDtD.jl",
    target = "build",
    devbranch="main"
)
