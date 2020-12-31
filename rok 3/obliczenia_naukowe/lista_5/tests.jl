using blocksys
using matrixgen
using PyPlot

sizes = [1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, 90000, 100000, 110000, 120000, 130000, 140000, 150000, 160000, 170000, 180000, 190000, 200000]
number_of_tests = length(sizes)
l = 5
cond = Float64(1.0)
mat_file_path = "tmp_matrix.txt"

# operations
gauss_o = Array{Float64}(undef, number_of_tests)
gauss_main_o = Array{Float64}(undef, number_of_tests)
lu_o = Array{Float64}(undef, number_of_tests)
lu_main_o = Array{Float64}(undef, number_of_tests)
solve_lu_o = Array{Float64}(undef, number_of_tests)
solve_lu_main_o = Array{Float64}(undef, number_of_tests)

# memory
gauss_m = Array{Float64}(undef, number_of_tests)
gauss_main_m = Array{Float64}(undef, number_of_tests)
lu_m = Array{Float64}(undef, number_of_tests)
lu_main_m = Array{Float64}(undef, number_of_tests)
solve_lu_m = Array{Float64}(undef, number_of_tests)
solve_lu_main_m = Array{Float64}(undef, number_of_tests)

# time
gauss_t = Array{Float64}(undef, number_of_tests)
gauss_main_t = Array{Float64}(undef, number_of_tests)
lu_t = Array{Float64}(undef, number_of_tests)
lu_main_t = Array{Float64}(undef, number_of_tests)
solve_lu_t = Array{Float64}(undef, number_of_tests)
solve_lu_main_t = Array{Float64}(undef, number_of_tests)

for test in 1:number_of_tests
    """ Creating test matrix """
    blockmat(sizes[test], l, cond, mat_file_path)
################################################################################
    """ Loading test matrix and calculating right side vector b """
    mat_holder = read_matrix_from_file(mat_file_path)
    gen_b = calculate_vector_b(mat_holder[1], mat_holder[2], mat_holder[3])

    """ Testing gauss """
    measurment = @timed solve_gauss(mat_holder[1], gen_b, mat_holder[2], mat_holder[3])
    # saving measurment
    gauss_o[test] = sizes[test] * l^2 + 2sizes[test]
    gauss_m[test] = measurment[3]
    gauss_t[test] = measurment[2]

################################################################################
    """ Loading test matrix and calculating right side vector b """
    mat_holder = read_matrix_from_file(mat_file_path)
    gen_b = calculate_vector_b(mat_holder[1], mat_holder[2], mat_holder[3])

    """ Testing gauss with main element choosing """
    measurment = @timed solve_gauss_with_main_element(mat_holder[1], gen_b, mat_holder[2], mat_holder[3])
    # saving measurment
    gauss_main_o[test] = sizes[test] * l^3 + 2sizes[test]
    gauss_main_m[test] = measurment[3]
    gauss_main_t[test] = measurment[2]

################################################################################
    """ Loading test matrix and calculating right side vector b """
    mat_holder = read_matrix_from_file(mat_file_path)
    gen_b = calculate_vector_b(mat_holder[1], mat_holder[2], mat_holder[3])

    """ Testing lu """
    measurment = @timed do_lu(mat_holder[1], gen_b, mat_holder[2], mat_holder[3])
    # saving measurment
    lu_o[test] = sizes[test] * (l^2 + sizes[test])
    lu_m[test] = measurment[3]
    lu_t[test] = measurment[2]

    """ Testing solving lu """
    measurment = @timed solve_lu(measurment[1][1], measurment[1][2], mat_holder[2], mat_holder[3])
    # saving measurment
    solve_lu_o[test] = sizes[test] * (l^2 + 3l)
    solve_lu_m[test] = lu_m[test] + measurment[3]
    solve_lu_t[test] = lu_t[test] + measurment[2]

################################################################################
    """ Loading test matrix and calculating right side vector b """
    mat_holder = read_matrix_from_file(mat_file_path)
    gen_b = calculate_vector_b(mat_holder[1], mat_holder[2], mat_holder[3])

    """ Testing lu with main element choosing """
    measurment = @timed do_lu_with_main_element(mat_holder[1], gen_b, mat_holder[2], mat_holder[3])
    # saving measurment
    lu_main_o[test] = sizes[test] * (l^3 + sizes[test])
    lu_main_m[test] = measurment[3]
    lu_main_t[test] = measurment[2]

    """ Testing solving lu with main element choosing """
    measurment = @timed solve_lu_with_main_element(measurment[1][1], measurment[1][2], measurment[1][3], mat_holder[2], mat_holder[3])
    # saving measurment
    solve_lu_main_o[test] = sizes[test] * (l^2 + 3l)
    solve_lu_main_m[test] = lu_main_m[test] + measurment[3]
    solve_lu_main_t[test] = lu_main_t[test] + measurment[2]
end

""" Draw graphs part """

""" Operations """
clf()
plot(sizes, gauss_o, label="Gauss", linewidth=1.0)
plot(sizes, gauss_main_o, label="Gauss with main element choosing", linewidth=1.0)
plot(sizes, solve_lu_o, label="LU", linewidth=1.0)
plot(sizes, solve_lu_main_o, label="LU with main element choosing", linewidth=1.0)
grid(true)
legend(loc=2,borderaxespad=0)
title("Comparing operation usage.")
savefig("/home/gabriel/Desktop/studia/rok 3/obliczenia_naukowe/lista_5/operations.png")

""" Memory """
clf()
plot(sizes, gauss_m, label="Gauss", linewidth=1.0)
plot(sizes, gauss_main_m, label="Gauss with main element choosing", linewidth=1.0)
plot(sizes, solve_lu_m, label="LU", linewidth=1.0)
plot(sizes, solve_lu_main_m, label="LU with main element choosing", linewidth=1.0)
grid(true)
legend(loc=2,borderaxespad=0)
title("Comparing memory usage.")
savefig("/home/gabriel/Desktop/studia/rok 3/obliczenia_naukowe/lista_5/memory.png")

""" Time """
clf()
plot(sizes, gauss_t, label="Gauss", linewidth=1.0)
plot(sizes, gauss_main_t, label="Gauss with main element choosing", linewidth=1.0)
plot(sizes, solve_lu_t, label="LU", linewidth=1.0)
plot(sizes, solve_lu_main_t, label="LU with main element choosing", linewidth=1.0)
grid(true)
legend(loc=2,borderaxespad=0)
title("Comparing solving times.")
savefig("/home/gabriel/Desktop/studia/rok 3/obliczenia_naukowe/lista_5/times.png")
