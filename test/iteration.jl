@testset "CSV.File iteration" begin
    for file in ("test_not_enough_columns.csv", "test_correct_trailing_missings.csv")
        f = CSV.File(joinpath(dir, file), allowmissing=:auto)
    
        @test isequal(map(row->row.A, f), [1, 4])
        @test isequal(map(row->row.B, f), [2, 5])
        @test isequal(map(row->row.C, f), [3, 6])
        @test isequal(map(row->row.D, f), [missing, missing])
        @test isequal(map(row->row.E, f), [missing, missing])

        @test isequal(map(row->(row.A, row.A, row.A), f), [(1, 1, 1), (4, 4, 4)])
        @test isequal(map(row->(row.B, row.B, row.B), f), [(2, 2, 2), (5, 5, 5)])
        @test isequal(map(row->(row.C, row.C, row.C), f), [(3, 3, 3), (6, 6, 6)])
        @test isequal(map(row->(row.D, row.D, row.D), f), [(missing, missing, missing), (missing, missing, missing)])
        @test isequal(map(row->(row.E, row.E, row.E), f), [(missing, missing, missing), (missing, missing, missing)])
        
        @test isequal(map(row->(row.A, row.D), f), [(1, missing), (4, missing)])
        @test isequal(map(row->(row.A, row.E), f), [(1, missing), (4, missing)])
        @test isequal(map(row->(row.B, row.D), f), [(2, missing), (5, missing)])
        @test isequal(map(row->(row.B, row.E), f), [(2, missing), (5, missing)])
        @test isequal(map(row->(row.C, row.D), f), [(3, missing), (6, missing)])
        @test isequal(map(row->(row.C, row.E), f), [(3, missing), (6, missing)])

        @test isequal(map(row->(row.D, row.A), f), [(missing, 1), (missing, 4)])
        @test isequal(map(row->(row.E, row.A), f), [(missing, 1), (missing, 4)])
        @test isequal(map(row->(row.D, row.B), f), [(missing, 2), (missing, 5)])
        @test isequal(map(row->(row.E, row.B), f), [(missing, 2), (missing, 5)])
        @test isequal(map(row->(row.D, row.C), f), [(missing, 3), (missing, 6)])
        @test isequal(map(row->(row.E, row.C), f), [(missing, 3), (missing, 6)])

        @test isequal(map(row->(row.A, row.C), f), [(1, 3), (4, 6)])
        @test isequal(map(row->(row.C, row.A), f), [(3, 1), (6, 4)])
        @test isequal(map(row->(row.B, row.C), f), [(2, 3), (5, 6)])
        @test isequal(map(row->(row.C, row.B), f), [(3, 2), (6, 5)])
        
        @test isequal(map(row->(row.A, row.B), f), [(1, 2), (4, 5)])
        @test isequal(map(row->(row.B, row.A), f), [(2, 1), (5, 4)])
        
        @test isequal(map(row->(row.A, row.B, row.C), f), [(1, 2, 3), (4, 5, 6)])
        @test isequal(map(row->(row.B, row.A, row.C), f), [(2, 1, 3), (5, 4, 6)])
        @test isequal(map(row->(row.A, row.C, row.B), f), [(1, 3, 2), (4, 6, 5)])
        @test isequal(map(row->(row.B, row.C, row.A), f), [(2, 3, 1), (5, 6, 4)])
        @test isequal(map(row->(row.C, row.A, row.B), f), [(3, 1, 2), (6, 4, 5)])
        @test isequal(map(row->(row.C, row.B, row.A), f), [(3, 2, 1), (6, 5, 4)])

        @test isequal(map(row->(row.A, row.B, row.C, row.D), f), [(1, 2, 3, missing), (4, 5, 6, missing)])
        @test isequal(map(row->(row.B, row.A, row.C, row.D), f), [(2, 1, 3, missing), (5, 4, 6, missing)])
        @test isequal(map(row->(row.A, row.C, row.B, row.D), f), [(1, 3, 2, missing), (4, 6, 5, missing)])
        @test isequal(map(row->(row.B, row.C, row.A, row.D), f), [(2, 3, 1, missing), (5, 6, 4, missing)])
        @test isequal(map(row->(row.C, row.A, row.B, row.D), f), [(3, 1, 2, missing), (6, 4, 5, missing)])
        @test isequal(map(row->(row.C, row.B, row.A, row.D), f), [(3, 2, 1, missing), (6, 5, 4, missing)])
        @test isequal(map(row->(row.A, row.B, row.D, row.C), f), [(1, 2, missing, 3), (4, 5, missing, 6)])
        @test isequal(map(row->(row.B, row.A, row.D, row.C), f), [(2, 1, missing, 3), (5, 4, missing, 6)])
        @test isequal(map(row->(row.A, row.C, row.D, row.B), f), [(1, 3, missing, 2), (4, 6, missing, 5)])
        @test isequal(map(row->(row.B, row.C, row.D, row.A), f), [(2, 3, missing, 1), (5, 6, missing, 4)])
        @test isequal(map(row->(row.C, row.A, row.D, row.B), f), [(3, 1, missing, 2), (6, 4, missing, 5)])
        @test isequal(map(row->(row.C, row.B, row.D, row.A), f), [(3, 2, missing, 1), (6, 5, missing, 4)])
        @test isequal(map(row->(row.A, row.D, row.B, row.C), f), [(1, missing, 2, 3), (4, missing, 5, 6)])
        @test isequal(map(row->(row.B, row.D, row.A, row.C), f), [(2, missing, 1, 3), (5, missing, 4, 6)])
        @test isequal(map(row->(row.A, row.D, row.C, row.B), f), [(1, missing, 3, 2), (4, missing, 6, 5)])
        @test isequal(map(row->(row.B, row.D, row.C, row.A), f), [(2, missing, 3, 1), (5, missing, 6, 4)])
        @test isequal(map(row->(row.C, row.D, row.A, row.B), f), [(3, missing, 1, 2), (6, missing, 4, 5)])
        @test isequal(map(row->(row.C, row.D, row.B, row.A), f), [(3, missing, 2, 1), (6, missing, 5, 4)])
        @test isequal(map(row->(row.D, row.A, row.B, row.C), f), [(missing, 1, 2, 3), (missing, 4, 5, 6)])
        @test isequal(map(row->(row.D, row.B, row.A, row.C), f), [(missing, 2, 1, 3), (missing, 5, 4, 6)])
        @test isequal(map(row->(row.D, row.A, row.C, row.B), f), [(missing, 1, 3, 2), (missing, 4, 6, 5)])
        @test isequal(map(row->(row.D, row.B, row.C, row.A), f), [(missing, 2, 3, 1), (missing, 5, 6, 4)])
        @test isequal(map(row->(row.D, row.C, row.A, row.B), f), [(missing, 3, 1, 2), (missing, 6, 4, 5)])
        @test isequal(map(row->(row.D, row.C, row.B, row.A), f), [(missing, 3, 2, 1), (missing, 6, 5, 4)])

        @test isequal(map(row->(row.A, row.B, row.C, row.D, row.E), f), [(1, 2, 3, missing, missing), (4, 5, 6, missing, missing)])
        @test isequal(map(row->(row.B, row.A, row.C, row.D, row.E), f), [(2, 1, 3, missing, missing), (5, 4, 6, missing, missing)])
        @test isequal(map(row->(row.A, row.C, row.B, row.D, row.E), f), [(1, 3, 2, missing, missing), (4, 6, 5, missing, missing)])
        @test isequal(map(row->(row.B, row.C, row.A, row.D, row.E), f), [(2, 3, 1, missing, missing), (5, 6, 4, missing, missing)])
        @test isequal(map(row->(row.C, row.A, row.B, row.D, row.E), f), [(3, 1, 2, missing, missing), (6, 4, 5, missing, missing)])
        @test isequal(map(row->(row.C, row.B, row.A, row.D, row.E), f), [(3, 2, 1, missing, missing), (6, 5, 4, missing, missing)])
        @test isequal(map(row->(row.A, row.B, row.D, row.C, row.E), f), [(1, 2, missing, 3, missing), (4, 5, missing, 6, missing)])
        @test isequal(map(row->(row.B, row.A, row.D, row.C, row.E), f), [(2, 1, missing, 3, missing), (5, 4, missing, 6, missing)])
        @test isequal(map(row->(row.A, row.C, row.D, row.B, row.E), f), [(1, 3, missing, 2, missing), (4, 6, missing, 5, missing)])
        @test isequal(map(row->(row.B, row.C, row.D, row.A, row.E), f), [(2, 3, missing, 1, missing), (5, 6, missing, 4, missing)])
        @test isequal(map(row->(row.C, row.A, row.D, row.B, row.E), f), [(3, 1, missing, 2, missing), (6, 4, missing, 5, missing)])
        @test isequal(map(row->(row.C, row.B, row.D, row.A, row.E), f), [(3, 2, missing, 1, missing), (6, 5, missing, 4, missing)])
        @test isequal(map(row->(row.A, row.D, row.B, row.C, row.E), f), [(1, missing, 2, 3, missing), (4, missing, 5, 6, missing)])
        @test isequal(map(row->(row.B, row.D, row.A, row.C, row.E), f), [(2, missing, 1, 3, missing), (5, missing, 4, 6, missing)])
        @test isequal(map(row->(row.A, row.D, row.C, row.B, row.E), f), [(1, missing, 3, 2, missing), (4, missing, 6, 5, missing)])
        @test isequal(map(row->(row.B, row.D, row.C, row.A, row.E), f), [(2, missing, 3, 1, missing), (5, missing, 6, 4, missing)])
        @test isequal(map(row->(row.C, row.D, row.A, row.B, row.E), f), [(3, missing, 1, 2, missing), (6, missing, 4, 5, missing)])
        @test isequal(map(row->(row.C, row.D, row.B, row.A, row.E), f), [(3, missing, 2, 1, missing), (6, missing, 5, 4, missing)])
        @test isequal(map(row->(row.D, row.A, row.B, row.C, row.E), f), [(missing, 1, 2, 3, missing), (missing, 4, 5, 6, missing)])
        @test isequal(map(row->(row.D, row.B, row.A, row.C, row.E), f), [(missing, 2, 1, 3, missing), (missing, 5, 4, 6, missing)])
        @test isequal(map(row->(row.D, row.A, row.C, row.B, row.E), f), [(missing, 1, 3, 2, missing), (missing, 4, 6, 5, missing)])
        @test isequal(map(row->(row.D, row.B, row.C, row.A, row.E), f), [(missing, 2, 3, 1, missing), (missing, 5, 6, 4, missing)])
        @test isequal(map(row->(row.D, row.C, row.A, row.B, row.E), f), [(missing, 3, 1, 2, missing), (missing, 6, 4, 5, missing)])
        @test isequal(map(row->(row.D, row.C, row.B, row.A, row.E), f), [(missing, 3, 2, 1, missing), (missing, 6, 5, 4, missing)])

        @test isequal(map(row->(row.A, row.B, row.C, row.E, row.D), f), [(1, 2, 3, missing, missing), (4, 5, 6, missing, missing)])
        @test isequal(map(row->(row.B, row.A, row.C, row.E, row.D), f), [(2, 1, 3, missing, missing), (5, 4, 6, missing, missing)])
        @test isequal(map(row->(row.A, row.C, row.B, row.E, row.D), f), [(1, 3, 2, missing, missing), (4, 6, 5, missing, missing)])
        @test isequal(map(row->(row.B, row.C, row.A, row.E, row.D), f), [(2, 3, 1, missing, missing), (5, 6, 4, missing, missing)])
        @test isequal(map(row->(row.C, row.A, row.B, row.E, row.D), f), [(3, 1, 2, missing, missing), (6, 4, 5, missing, missing)])
        @test isequal(map(row->(row.C, row.B, row.A, row.E, row.D), f), [(3, 2, 1, missing, missing), (6, 5, 4, missing, missing)])
        @test isequal(map(row->(row.A, row.B, row.D, row.E, row.C), f), [(1, 2, missing, missing, 3), (4, 5, missing, missing, 6)])
        @test isequal(map(row->(row.B, row.A, row.D, row.E, row.C), f), [(2, 1, missing, missing, 3), (5, 4, missing, missing, 6)])
        @test isequal(map(row->(row.A, row.C, row.D, row.E, row.B), f), [(1, 3, missing, missing, 2), (4, 6, missing, missing, 5)])
        @test isequal(map(row->(row.B, row.C, row.D, row.E, row.A), f), [(2, 3, missing, missing, 1), (5, 6, missing, missing, 4)])
        @test isequal(map(row->(row.C, row.A, row.D, row.E, row.B), f), [(3, 1, missing, missing, 2), (6, 4, missing, missing, 5)])
        @test isequal(map(row->(row.C, row.B, row.D, row.E, row.A), f), [(3, 2, missing, missing, 1), (6, 5, missing, missing, 4)])
        @test isequal(map(row->(row.A, row.D, row.B, row.E, row.C), f), [(1, missing, 2, missing, 3), (4, missing, 5, missing, 6)])
        @test isequal(map(row->(row.B, row.D, row.A, row.E, row.C), f), [(2, missing, 1, missing, 3), (5, missing, 4, missing, 6)])
        @test isequal(map(row->(row.A, row.D, row.C, row.E, row.B), f), [(1, missing, 3, missing, 2), (4, missing, 6, missing, 5)])
        @test isequal(map(row->(row.B, row.D, row.C, row.E, row.A), f), [(2, missing, 3, missing, 1), (5, missing, 6, missing, 4)])
        @test isequal(map(row->(row.C, row.D, row.A, row.E, row.B), f), [(3, missing, 1, missing, 2), (6, missing, 4, missing, 5)])
        @test isequal(map(row->(row.C, row.D, row.B, row.E, row.A), f), [(3, missing, 2, missing, 1), (6, missing, 5, missing, 4)])
        @test isequal(map(row->(row.D, row.A, row.B, row.E, row.C), f), [(missing, 1, 2, missing, 3), (missing, 4, 5, missing, 6)])
        @test isequal(map(row->(row.D, row.B, row.A, row.E, row.C), f), [(missing, 2, 1, missing, 3), (missing, 5, 4, missing, 6)])
        @test isequal(map(row->(row.D, row.A, row.C, row.E, row.B), f), [(missing, 1, 3, missing, 2), (missing, 4, 6, missing, 5)])
        @test isequal(map(row->(row.D, row.B, row.C, row.E, row.A), f), [(missing, 2, 3, missing, 1), (missing, 5, 6, missing, 4)])
        @test isequal(map(row->(row.D, row.C, row.A, row.E, row.B), f), [(missing, 3, 1, missing, 2), (missing, 6, 4, missing, 5)])
        @test isequal(map(row->(row.D, row.C, row.B, row.E, row.A), f), [(missing, 3, 2, missing, 1), (missing, 6, 5, missing, 4)])

        @test isequal(map(row->(row.A, row.B, row.E, row.C, row.D), f), [(1, 2, missing, 3, missing), (4, 5, missing, 6, missing)])
        @test isequal(map(row->(row.B, row.A, row.E, row.C, row.D), f), [(2, 1, missing, 3, missing), (5, 4, missing, 6, missing)])
        @test isequal(map(row->(row.A, row.C, row.E, row.B, row.D), f), [(1, 3, missing, 2, missing), (4, 6, missing, 5, missing)])
        @test isequal(map(row->(row.B, row.C, row.E, row.A, row.D), f), [(2, 3, missing, 1, missing), (5, 6, missing, 4, missing)])
        @test isequal(map(row->(row.C, row.A, row.E, row.B, row.D), f), [(3, 1, missing, 2, missing), (6, 4, missing, 5, missing)])
        @test isequal(map(row->(row.C, row.B, row.E, row.A, row.D), f), [(3, 2, missing, 1, missing), (6, 5, missing, 4, missing)])
        @test isequal(map(row->(row.A, row.B, row.E, row.D, row.C), f), [(1, 2, missing, missing, 3), (4, 5, missing, missing, 6)])
        @test isequal(map(row->(row.B, row.A, row.E, row.D, row.C), f), [(2, 1, missing, missing, 3), (5, 4, missing, missing, 6)])
        @test isequal(map(row->(row.A, row.C, row.E, row.D, row.B), f), [(1, 3, missing, missing, 2), (4, 6, missing, missing, 5)])
        @test isequal(map(row->(row.B, row.C, row.E, row.D, row.A), f), [(2, 3, missing, missing, 1), (5, 6, missing, missing, 4)])
        @test isequal(map(row->(row.C, row.A, row.E, row.D, row.B), f), [(3, 1, missing, missing, 2), (6, 4, missing, missing, 5)])
        @test isequal(map(row->(row.C, row.B, row.E, row.D, row.A), f), [(3, 2, missing, missing, 1), (6, 5, missing, missing, 4)])
        @test isequal(map(row->(row.A, row.D, row.E, row.B, row.C), f), [(1, missing, missing, 2, 3), (4, missing, missing, 5, 6)])
        @test isequal(map(row->(row.B, row.D, row.E, row.A, row.C), f), [(2, missing, missing, 1, 3), (5, missing, missing, 4, 6)])
        @test isequal(map(row->(row.A, row.D, row.E, row.C, row.B), f), [(1, missing, missing, 3, 2), (4, missing, missing, 6, 5)])
        @test isequal(map(row->(row.B, row.D, row.E, row.C, row.A), f), [(2, missing, missing, 3, 1), (5, missing, missing, 6, 4)])
        @test isequal(map(row->(row.C, row.D, row.E, row.A, row.B), f), [(3, missing, missing, 1, 2), (6, missing, missing, 4, 5)])
        @test isequal(map(row->(row.C, row.D, row.E, row.B, row.A), f), [(3, missing, missing, 2, 1), (6, missing, missing, 5, 4)])
        @test isequal(map(row->(row.D, row.A, row.E, row.B, row.C), f), [(missing, 1, missing, 2, 3), (missing, 4, missing, 5, 6)])
        @test isequal(map(row->(row.D, row.B, row.E, row.A, row.C), f), [(missing, 2, missing, 1, 3), (missing, 5, missing, 4, 6)])
        @test isequal(map(row->(row.D, row.A, row.E, row.C, row.B), f), [(missing, 1, missing, 3, 2), (missing, 4, missing, 6, 5)])
        @test isequal(map(row->(row.D, row.B, row.E, row.C, row.A), f), [(missing, 2, missing, 3, 1), (missing, 5, missing, 6, 4)])
        @test isequal(map(row->(row.D, row.C, row.E, row.A, row.B), f), [(missing, 3, missing, 1, 2), (missing, 6, missing, 4, 5)])
        @test isequal(map(row->(row.D, row.C, row.E, row.B, row.A), f), [(missing, 3, missing, 2, 1), (missing, 6, missing, 5, 4)])

        @test isequal(map(row->(row.A, row.E, row.B, row.C, row.D), f), [(1, missing, 2, 3, missing), (4, missing, 5, 6, missing)])
        @test isequal(map(row->(row.B, row.E, row.A, row.C, row.D), f), [(2, missing, 1, 3, missing), (5, missing, 4, 6, missing)])
        @test isequal(map(row->(row.A, row.E, row.C, row.B, row.D), f), [(1, missing, 3, 2, missing), (4, missing, 6, 5, missing)])
        @test isequal(map(row->(row.B, row.E, row.C, row.A, row.D), f), [(2, missing, 3, 1, missing), (5, missing, 6, 4, missing)])
        @test isequal(map(row->(row.C, row.E, row.A, row.B, row.D), f), [(3, missing, 1, 2, missing), (6, missing, 4, 5, missing)])
        @test isequal(map(row->(row.C, row.E, row.B, row.A, row.D), f), [(3, missing, 2, 1, missing), (6, missing, 5, 4, missing)])
        @test isequal(map(row->(row.A, row.E, row.B, row.D, row.C), f), [(1, missing, 2, missing, 3), (4, missing, 5, missing, 6)])
        @test isequal(map(row->(row.B, row.E, row.A, row.D, row.C), f), [(2, missing, 1, missing, 3), (5, missing, 4, missing, 6)])
        @test isequal(map(row->(row.A, row.E, row.C, row.D, row.B), f), [(1, missing, 3, missing, 2), (4, missing, 6, missing, 5)])
        @test isequal(map(row->(row.B, row.E, row.C, row.D, row.A), f), [(2, missing, 3, missing, 1), (5, missing, 6, missing, 4)])
        @test isequal(map(row->(row.C, row.E, row.A, row.D, row.B), f), [(3, missing, 1, missing, 2), (6, missing, 4, missing, 5)])
        @test isequal(map(row->(row.C, row.E, row.B, row.D, row.A), f), [(3, missing, 2, missing, 1), (6, missing, 5, missing, 4)])
        @test isequal(map(row->(row.A, row.E, row.D, row.B, row.C), f), [(1, missing, missing, 2, 3), (4, missing, missing, 5, 6)])
        @test isequal(map(row->(row.B, row.E, row.D, row.A, row.C), f), [(2, missing, missing, 1, 3), (5, missing, missing, 4, 6)])
        @test isequal(map(row->(row.A, row.E, row.D, row.C, row.B), f), [(1, missing, missing, 3, 2), (4, missing, missing, 6, 5)])
        @test isequal(map(row->(row.B, row.E, row.D, row.C, row.A), f), [(2, missing, missing, 3, 1), (5, missing, missing, 6, 4)])
        @test isequal(map(row->(row.C, row.E, row.D, row.A, row.B), f), [(3, missing, missing, 1, 2), (6, missing, missing, 4, 5)])
        @test isequal(map(row->(row.C, row.E, row.D, row.B, row.A), f), [(3, missing, missing, 2, 1), (6, missing, missing, 5, 4)])
        @test isequal(map(row->(row.D, row.E, row.A, row.B, row.C), f), [(missing, missing, 1, 2, 3), (missing, missing, 4, 5, 6)])
        @test isequal(map(row->(row.D, row.E, row.B, row.A, row.C), f), [(missing, missing, 2, 1, 3), (missing, missing, 5, 4, 6)])
        @test isequal(map(row->(row.D, row.E, row.A, row.C, row.B), f), [(missing, missing, 1, 3, 2), (missing, missing, 4, 6, 5)])
        @test isequal(map(row->(row.D, row.E, row.B, row.C, row.A), f), [(missing, missing, 2, 3, 1), (missing, missing, 5, 6, 4)])
        @test isequal(map(row->(row.D, row.E, row.C, row.A, row.B), f), [(missing, missing, 3, 1, 2), (missing, missing, 6, 4, 5)])
        @test isequal(map(row->(row.D, row.E, row.C, row.B, row.A), f), [(missing, missing, 3, 2, 1), (missing, missing, 6, 5, 4)])

        @test isequal(map(row->(row.E, row.A, row.B, row.C, row.D), f), [(missing, 1, 2, 3, missing), (missing, 4, 5, 6, missing)])
        @test isequal(map(row->(row.E, row.B, row.A, row.C, row.D), f), [(missing, 2, 1, 3, missing), (missing, 5, 4, 6, missing)])
        @test isequal(map(row->(row.E, row.A, row.C, row.B, row.D), f), [(missing, 1, 3, 2, missing), (missing, 4, 6, 5, missing)])
        @test isequal(map(row->(row.E, row.B, row.C, row.A, row.D), f), [(missing, 2, 3, 1, missing), (missing, 5, 6, 4, missing)])
        @test isequal(map(row->(row.E, row.C, row.A, row.B, row.D), f), [(missing, 3, 1, 2, missing), (missing, 6, 4, 5, missing)])
        @test isequal(map(row->(row.E, row.C, row.B, row.A, row.D), f), [(missing, 3, 2, 1, missing), (missing, 6, 5, 4, missing)])
        @test isequal(map(row->(row.E, row.A, row.B, row.D, row.C), f), [(missing, 1, 2, missing, 3), (missing, 4, 5, missing, 6)])
        @test isequal(map(row->(row.E, row.B, row.A, row.D, row.C), f), [(missing, 2, 1, missing, 3), (missing, 5, 4, missing, 6)])
        @test isequal(map(row->(row.E, row.A, row.C, row.D, row.B), f), [(missing, 1, 3, missing, 2), (missing, 4, 6, missing, 5)])
        @test isequal(map(row->(row.E, row.B, row.C, row.D, row.A), f), [(missing, 2, 3, missing, 1), (missing, 5, 6, missing, 4)])
        @test isequal(map(row->(row.E, row.C, row.A, row.D, row.B), f), [(missing, 3, 1, missing, 2), (missing, 6, 4, missing, 5)])
        @test isequal(map(row->(row.E, row.C, row.B, row.D, row.A), f), [(missing, 3, 2, missing, 1), (missing, 6, 5, missing, 4)])
        @test isequal(map(row->(row.E, row.A, row.D, row.B, row.C), f), [(missing, 1, missing, 2, 3), (missing, 4, missing, 5, 6)])
        @test isequal(map(row->(row.E, row.B, row.D, row.A, row.C), f), [(missing, 2, missing, 1, 3), (missing, 5, missing, 4, 6)])
        @test isequal(map(row->(row.E, row.A, row.D, row.C, row.B), f), [(missing, 1, missing, 3, 2), (missing, 4, missing, 6, 5)])
        @test isequal(map(row->(row.E, row.B, row.D, row.C, row.A), f), [(missing, 2, missing, 3, 1), (missing, 5, missing, 6, 4)])
        @test isequal(map(row->(row.E, row.C, row.D, row.A, row.B), f), [(missing, 3, missing, 1, 2), (missing, 6, missing, 4, 5)])
        @test isequal(map(row->(row.E, row.C, row.D, row.B, row.A), f), [(missing, 3, missing, 2, 1), (missing, 6, missing, 5, 4)])
        @test isequal(map(row->(row.E, row.D, row.A, row.B, row.C), f), [(missing, missing, 1, 2, 3), (missing, missing, 4, 5, 6)])
        @test isequal(map(row->(row.E, row.D, row.B, row.A, row.C), f), [(missing, missing, 2, 1, 3), (missing, missing, 5, 4, 6)])
        @test isequal(map(row->(row.E, row.D, row.A, row.C, row.B), f), [(missing, missing, 1, 3, 2), (missing, missing, 4, 6, 5)])
        @test isequal(map(row->(row.E, row.D, row.B, row.C, row.A), f), [(missing, missing, 2, 3, 1), (missing, missing, 5, 6, 4)])
        @test isequal(map(row->(row.E, row.D, row.C, row.A, row.B), f), [(missing, missing, 3, 1, 2), (missing, missing, 6, 4, 5)])
        @test isequal(map(row->(row.E, row.D, row.C, row.B, row.A), f), [(missing, missing, 3, 2, 1), (missing, missing, 6, 5, 4)])
    end
end
