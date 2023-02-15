module MertonDtD

using Distributions, Optim
export dtd
"""
This function implements the Merton Model (1974) to compute a measure of credit risk of a firm: Distance to default (DtD). DtD indicates how many standard deviations is a firm away from the default point.

    Inputs: 

    mcap: Is a scalar specifying the market capital of the firm.               

    debt: Is a scalar specifying the threshold level of debt for the firm below which the firm will default. Should be a non-zero number.

     vol: Is a scalar specifying the equity volatility of the firm.

       r: Is a scalar specifying the annualized risk free interest rate.

Outputs:

          a dtd object is returned, which has 3 elements:
        
        dtd.v: Distance to default value of the firm                                
       
        asset.v: Estimated asset value of the firm                                    
       
        sigma.v: Estimated volatility of the asset value of the firm
       
Example: 
```jldoctest
julia> dtd(100, 70, 0.3, 0.1) |> print
dtd_v: 3.33333306534595
asset_v: 3.33333306534595
sigma_v: 3.33333306534595
```

"""
struct dtd
    dtd_v
    asset_v
    sigma_v
end

function Base.show(io::IO, x::dtd)  
    printstyled("dtd_v: "; bold = true)
    println(x.dtd_v)
    printstyled("asset_v: "; bold = true)
    println(x.dtd_v)
    printstyled("sigma_v: "; bold = true)
    println(x.dtd_v)
end

function dtd(mcap, debt, vol, r)
    if debt == 0
        @error "debt should be nonzero"
end
rho = 1                 # forbearance
Maturity = 1
## Starting values of firm's market value and its volatility
seed_V = mcap + debt
seed_sV = mcap * vol / debt
debt = debt * exp(-r)


function d1(V, debt, sV, Maturity)
    num = log(V/debt) + 0.5*sV*sV*Maturity
    den = sV * sqrt(Maturity)
    return num/den
end
    
function d2(V, debt, sV, Maturity)
    return d1(V, debt, sV, Maturity) - sV*sqrt(Maturity)
end

function pnorm(x) 
    return cdf(Normal(0, 1), x)
end


function objective_function(x, mcap, vol, debt, rho, Maturity)
    e1 = -mcap + x[1]*pnorm(d1(x[1], debt*rho, x[2], Maturity)) -rho*debt*pnorm(d2(x[1], rho*debt, x[2], Maturity))
    e2 = -vol*mcap + x[2]*x[1]*pnorm(d1(x[1], debt*rho, x[2], Maturity))
    return (e1*e1) + (e2*e2)
end 

function f(x)
    return objective_function(x, mcap, vol, debt, rho, Maturity)
end

lower = [mcap, 0]
upper = [Inf, Inf]
initial_x = [seed_V, seed_sV]
inner_optimizer = LBFGS()
results = Optim.minimizer(optimize(f, lower, upper, initial_x, Fminbox(inner_optimizer), autodiff=:forward))
dtd_v = (results[1] - debt)/(results[1]*results[2])
res = Dict()
dtd(dtd_v, results[1], results[2])
end

end
