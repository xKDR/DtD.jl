# DtD

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://xKDR.github.io/DtD.jl/dev)
![Build Status](https://github.com/xKDR/DtD.jl/actions/workflows/ci.yml/badge.svg)
![Build Status](https://github.com/xKDR/DtD.jl/actions/workflows/documentation.yml/badge.svg)
[![codecov](https://codecov.io/gh/xKDR/DtD}.jl/branch/main/graph/badge.svg?token=<token>)](https://codecov.io/gh/xKDR/DtD}.jl)

DtD is calculated as the difference between the market value of the assets of the firm and the face value of its debt, scaled by the standard deviation of the firm's asset value. While the face value of the debt of the firm is known, the market value of the assets is not.

Exploiting the option nature of equity as a European call option on the underlying assets of a firm, the Merton Model (1974) derives the implied market value of the firm's assets and its volatility by solving the Black-Scholes (BS) equation backwards. 

The dtd function of the package implements the Merton Model to compute a measure of credit risk of a firm: Distance to default (DtD). DtD indicates how many standard deviations is a firm away from the default point.

This package implements the [dtd function from ifrogs package in R](https://https://github.com/ifrogs/ifrogs/blob/master/R/dtd.R)

# To install:
    add "https://github.com/xKDR/DtD.jl.git"

# Example:

    marketcap = 100 # market capital of the firm
    debt = 70 # threshold level of debt for the firm below which the firm will default
    vol = 0.3 # equity volatility 
    r = 0.1 # annualized risk free interest rate.

    x = dtd(marketcap, debt, vol, r) 

# Performance
    