push!(LOAD_PATH, pwd())
using blocksys
using matrixgen

mat_file_name = "tmp_matrix.txt"

if length(ARGS) <= 2
	print("usage: expected 4 arguments:\t
	n - matrix size,\t
	l - block size (n is divisible by l),\t
	cond - matrix's condition.\n")
end

n = parse(Int64, ARGS[1])
l = parse(Int64, ARGS[2])
cond = parse(Float64, ARGS[3])

blockmat(n, l, cond, mat_file_name)

"""GAUSS PART"""
mat_holder = read_matrix_from_file(pwd() * "/" * mat_file_name)
gen_b = calculate_vector_b(mat_holder[1], mat_holder[2], mat_holder[3])
x = solve_gauss(mat_holder[1], gen_b, mat_holder[2], mat_holder[3])
save_results_to_file(pwd() * "/" * "gauss_sol.txt", x, mat_holder[2], true)

"""GAUSS MAIN PART"""
mat_holder = read_matrix_from_file(pwd() * "/" * mat_file_name)
gen_b = calculate_vector_b(mat_holder[1], mat_holder[2], mat_holder[3])
x = solve_gauss_with_main_element(mat_holder[1], gen_b, mat_holder[2], mat_holder[3])
save_results_to_file(pwd() * "/" * "gauss_main_sol.txt", x, mat_holder[2], true)

"""LU PART"""
mat_holder = read_matrix_from_file(pwd() * "/" * mat_file_name)
gen_b = calculate_vector_b(mat_holder[1], mat_holder[2], mat_holder[3])
x = solve_gauss_with_main_element(mat_holder[1], gen_b, mat_holder[2], mat_holder[3])
save_results_to_file(pwd() * "/" * "lu_sol.txt", x, mat_holder[2], true)

"""LU MAIN PART"""
mat_holder = read_matrix_from_file(pwd() * "/" * mat_file_name)
gen_b = calculate_vector_b(mat_holder[1], mat_holder[2], mat_holder[3])
x = solve_gauss_with_main_element(mat_holder[1], gen_b, mat_holder[2], mat_holder[3])
save_results_to_file(pwd() * "/" * "lu_main_sol.txt", x, mat_holder[2], true)
