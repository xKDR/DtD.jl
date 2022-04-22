```@meta
CurrentModule = DtD
```

# DtD

Documentation for [DtD](https://github.com/DtD.jl).

DtD is calculated as the difference between the market value of the assets of the firm and the face value of its debt, scaled by the standard deviation of the firm's asset value. While the face value of the debt of the firm is known, the market value of the assets is not.

Exploiting the option nature of equity as a European call option on the underlying assets of a firm, the Merton Model (1974) derives the implied market value of the firm's assets and its volatility by solving the Black-Scholes (BS) equation backwards.          


```@index
```

```@autodocs
Modules = [DtD]
```
