using MertonDtD
using Test

@testset "MertonDtD.jl" begin
    tolerance = 1.0e-5

    x = dtd(100, 70, 0.3, 0.1) 
    @test x.dtd_v   ≈ 3.3333331   atol=tolerance
    @test x.asset_v ≈ 163.3386188 atol=tolerance
    @test x.sigma_v ≈ 0.1836675   atol=tolerance

    x = dtd(100, 60, 0.3, 0.1) 

    @test x.dtd_v   ≈ 3.3333331   atol=tolerance
    @test x.asset_v ≈ 154.2902450 atol=tolerance
    @test x.sigma_v ≈ 0.1944387   atol=tolerance

    x = dtd(100, 60, 0.5, 0.1) 
    @test x.dtd_v ≈ 1.999185     atol=tolerance
    @test x.asset_v ≈ 154.285232 atol=tolerance
    @test x.sigma_v ≈ 0.324191   atol=tolerance

    x = dtd(100, 60, 0.5, 0.4) 
    @test x.dtd_v   ≈ 1.999736   atol=tolerance
    @test x.asset_v ≈ 140.217668 atol=tolerance
    @test x.sigma_v ≈ 0.356630   atol=tolerance

    x = dtd(40, 60, 0.5, 0.4) 
    @test x.dtd_v   ≈ 1.9955117  atol=tolerance
    @test x.asset_v ≈ 80.2070512 atol=tolerance
    @test x.sigma_v ≈ 0.2498396  atol=tolerance

end
