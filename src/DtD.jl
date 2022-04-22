module DtD

using Distributions, Optim

dtd = function(mcap, debt, vol, r)

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
    res["dtd.v"] = dtd_v
    res["asset.v"] = results[1]
    res["sigma.v"] = results[2]

    return res
end

end
