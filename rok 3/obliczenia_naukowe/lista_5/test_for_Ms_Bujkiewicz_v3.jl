push!(LOAD_PATH, pwd())
using blocksys
using matrixgen

if length(ARGS) == 2
	mat_file_name = ARGS[1]
	vec_file_name = ARGS[2]
	"""GAUSS PART"""
	mat_holder = read_matrix_from_file(pwd() * "/" * mat_file_name)
	gen_b, n = read_right_side_vector_from_file(vec_file_name)
	x = solve_gauss(mat_holder[1], gen_b, mat_holder[2], mat_holder[3])
	save_results_to_file(pwd() * "/" * "gauss_sol.txt", x, mat_holder[2], true)

	"""GAUSS MAIN PART"""
	mat_holder = read_matrix_from_file(pwd() * "/" * mat_file_name)
	gen_b, n = read_right_side_vector_from_file(vec_file_name)
	x = solve_gauss_with_main_element(mat_holder[1], gen_b, mat_holder[2], mat_holder[3])
	save_results_to_file(pwd() * "/" * "gauss_main_sol.txt", x, mat_holder[2], true)

	"""LU PART"""
	mat_holder = read_matrix_from_file(pwd() * "/" * mat_file_name)
	gen_b, n = read_right_side_vector_from_file(vec_file_name)
	x = solve_gauss_with_main_element(mat_holder[1], gen_b, mat_holder[2], mat_holder[3])
	save_results_to_file(pwd() * "/" * "lu_sol.txt", x, mat_holder[2], true)

	"""LU MAIN PART"""
	mat_holder = read_matrix_from_file(pwd() * "/" * mat_file_name)
	gen_b, n = read_right_side_vector_from_file(vec_file_name)
	x = solve_gauss_with_main_element(mat_holder[1], gen_b, mat_holder[2], mat_holder[3])
	save_results_to_file(pwd() * "/" * "lu_main_sol.txt", x, mat_holder[2], true)
else
	mat_file_name = ARGS[1]
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
end
