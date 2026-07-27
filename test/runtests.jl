using TestItemRunner

@testitem "Aqua.jl" begin
    import Aqua
    import ManyUICLI
    Aqua.test_all(ManyUICLI)
end

@run_package_tests
