# DtD

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://xKDR.github.io/DtD.jl/dev)
![Build Status](https://github.com/xKDR/DtD.jl/actions/workflows/ci.yml/badge.svg)
![Build Status](https://github.com/xKDR/DtD.jl/actions/workflows/documentation.yml/badge.svg)
[![codecov](https://codecov.io/gh/xKDR/DtD.jl/branch/main/graph/badge.svg?token=TCkDWBCTiB)](https://codecov.io/gh/xKDR/DtD.jl)

DtD is calculated as the difference between the market value of the assets of the firm and the face value of its debt, scaled by the standard deviation of the firm's asset value. While the face value of the debt of the firm is known, the market value of the assets is not.

Exploiting the option nature of equity as a European call option on the underlying assets of a firm, the Merton Model (1974) derives the implied market value of the firm's assets and its volatility by solving the Black-Scholes (BS) equation backwards. 

The dtd function of the package implements the Merton Model to compute a measure of credit risk of a firm: Distance to default (DtD). DtD indicates how many standard deviations is a firm away from the default point.

The dtd function in this package is a translated into Julia by looking at the [dtd function from ifrogs package in R](https://https://github.com/ifrogs/ifrogs/blob/master/R/dtd.R)

# To install:
    add "https://github.com/xKDR/DtD.jl.git"

# Basic usage:
```julia
using DtD
marketcap = 100 # market capital of the firm
debt = 70 # threshold level of debt for the firm below which the firm will default
vol = 0.3 # equity volatility 
r = 0.1 # annualized risk free interest rate.

dtd(marketcap, debt, vol, r) 
```

# Performance:

We will benchmark the example shown above in R and Julia. 

**R**

```R
> library(ifrogs)
> library(microbenchmark)
> microbenchmark(dtd(100, 70, 0.3, 0.1))
```
```
    Unit: microseconds
                    expr     min      lq     mean  median      uq      max neval
    dtd(100, 70, 0.3, 0.1) 585.719 591.675 621.3032 594.044 600.286 2753.003   100
```
**Julia**
```julia
using DtD
using BenchmarkTools
@benchmark dtd(100, 70, 0.3, 0.1)
```

```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.                                       
 Range (min … max):  52.739 μs …   6.202 ms  ┊ GC (min … max): 0.00% … 98.29%                
 Time  (median):     55.164 μs               ┊ GC (median):    0.00%                         
 Time  (mean ± σ):   60.215 μs ± 161.294 μs  ┊ GC (mean ± σ):  7.52% ±  2.78%                
```

Distance to default is calculated in the innermost loops of programs. The Julia code being over 11 times faster can significantly speed up a program. 

# Support

We gratefully acknowledge the JuliaLab at MIT for financial support for this project.