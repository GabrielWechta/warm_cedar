module blocksys

export read_matrix_from_file, read_right_side_vector_from_file, gauss, gauss_choosing_main_element, solve_gauss, solve_gauss_with_main_element, do_lu, do_lu_with_main_element, solve_lu, solve_lu_with_main_element, calculate_vector_b, save_results_to_file

using SparseArrays

    function read_matrix_from_file(file_path::String)
        """
        file_path - absolute path to the file from which matrix is supposed to be red.

        OUT:
        A - the matrix, remembered as SparseMatrixCSC{Float64, Int64}.
        n - size of the matrix.
        l - block size.
        """
        open(file_path, "r") do file # opening file
            tmp_line = split(readline(file), " ") # first line - n and l
            n = parse(Int64, tmp_line[1])
            l = parse(Int64, tmp_line[2])

            A = spzeros(Float64, n, n) # creating forbidden fruit

            for line in eachline(file) # parsing values
                vars = split(line, " ")
                i = parse(Int64, vars[1])
                j = parse(Int64, vars[2])
                value = parse(Float64, vars[3])

                A[j, i] = value
            end
            return (A, n, l)
        end
    end

    function read_right_side_vector_from_file(file_path::String)
        """
        file_path - absolute path to the file from which vector is supposed to be red.

        OUT:
        b - vector, remembered as Vector{Float64}.
        n - size of the matrix. (Normally not needed)
        """
        open(file_path, "r") do file # opening file
            n = parse(Int64, readline(file)) # first line - n

            b = Vector{Float64}(undef, n)
            i = 1

            for line in eachline(file)
                b[i] = parse(Float64, line)
                i += 1
            end
            return (b, n)
        end
    end

    function gauss(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64, doing_LU::Bool)
        """
        DESC: This function does Gauss elimination. Because this function was designed especially for
        task given in assigment it uses how_many_to_eliminate::Int in order to optimize number of iterations.
        It can be done because in given column we always know how many elements must be removed.

        A - matrix, type SparseMatrixCSC{Float64, Int64}.
        b - right side vector, type Vector{Float64}.
        n - size of the matrix.
        l - block size.
        doing_LU - bool flag, when you want to do LU decomposition this should be true, else false.

        OUT:
        A - matrix after Gauss elimination (when doing_LU is true, A is LU decomposed).
        b - vector accordingly changed after elimination.
        """
        for k = 1:n-1 # k is for rows
            how_many_to_eliminate = k + (l - k % l) # optimazing

            for i = k + 1:how_many_to_eliminate # i is for columns
                multiplier = A[k, i] / A[k, k]

                if doing_LU == true
                    A[k, i] = multiplier
                else
                    A[k, i] = Float64(0.0)
                end

                for j = k + 1:min(k+l, n)
                    A[j, i] -= multiplier * A[j, k]
                end

                if doing_LU == false
                    b[i] -= multiplier * b[k]
                end
            end
        end
        return A, b
    end

    function solve_gauss(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
        """
        DESC: Standard way of calculating x in Ax = b, after Gauss elimination.

        A - matrix, type SparseMatrixCSC{Float64, Int64}.
        b - right side vector, type Vector{Float64}.
        n - size of the matrix.
        l - block size.

        OUT:
        x - solution vector, type Vector{Float64}.
        """
        A, b = gauss(A, b, n, l, false) # getting from gauss

        x = Vector{Float64}(undef, n) # answer vector

        for i = n:-1:1 # starting from end of A
            sum = Float64(0.0)

            for j = i + 1:min(n, i + l)
                sum += A[j, i] * x[j]
            end
            x[i] = (b[i] - sum) / A[i, i]
        end

        return x
    end

    function gauss_choosing_main_element(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64, doing_LU::Bool)
        """
        DESC: This function does Gauss elimination with choosing main element. Because this function was designed especially for
        a task given in the assignment, it uses how_many_to_eliminate::Int to optimize number of iterations.
        It can be done because in a given column we always know how many elements must be removed.
        Main idea is to save quality of solution (numerical problems) use the biggest (absolute) field in given column.
        It can be achieved quite easily with a permutation vector, which stores order of rows after being changed by choosing main element.

        A - matrix, type SparseMatrixCSC{Float64, Int64}.
        b - right side vector, type Vector{Float64}.
        n - size of the matrix.
        l - block size.
        doing_LU - bool flag, when you want to do LU decomposition this should be true, else false.

        OUT:
        A - matrix after Gauss elimination (when doing_LU is true, A is LU decomposed).
        permutation - vector holding order of rows.
        b - vector accordingly changed after elimination.
        """

        permutation = Vector{Int64}(undef, n)

        # initializing permutation vector
        # it will be used to "rotate" vector - b
        for i = 1:n
            permutation[i] = i
        end

        for k = 1:n-1 # k is for rows
            how_many_to_eliminate = k + (l - k % l) # optimazing
            row = k # row is for finding max element
            max_element = abs(A[k, k]) # variable for biggest element in columns

            for i = k:how_many_to_eliminate
                if abs(A[k, permutation[i]]) > max_element
                    max_element = abs(A[k, permutation[i]])
                    row = i
                end
            end

            # saving permutation
            permutation[k], permutation[row] = permutation[row], permutation[k]

            # standard part + fixing based on permutation
            for i = k + 1:how_many_to_eliminate
                multiplier = A[k, permutation[i]] / A[k, permutation[k]]

                if doing_LU == true
                    A[k, permutation[i]] = multiplier
                else
                    A[k, permutation[i]] = Float64(0.0)
                end

                for j = k + 1:min(k + 2 * l, n)
                    A[j, permutation[i]] -= multiplier * A[j, permutation[k]]
                end

                if doing_LU == false
                    b[permutation[i]] -= multiplier * b[permutation[k]]
                end
            end
        end
        return (A, permutation, b)
    end

    function solve_gauss_with_main_element(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
        """
        DESC: Standard way of calculating x in Ax = b, after Gauss elimination with choosing main element.

        A - matrix, type SparseMatrixCSC{Float64, Int64}.
        b - right side vector, type Vector{Float64}.
        n - size of the matrix.
        l - block size.

        OUT:
        x - solution vector, type Vector{Float64}.
        """
        A, permutation, b = gauss_choosing_main_element(A, b, n, l, false) # getting from gauss with choosing main element

        x = Vector{Float64}(undef, n) # answer vector

        for i = n:-1:1 # i is for rows
            sum = Float64(0.0)
            for j = i + 1:min(i + 2 * l + 1, n) # j is for columns
                sum += A[j, permutation[i]] * x[j]
            end

            x[i] = (b[permutation[i]] - sum) / A[i, permutation[i]] # calculating x based on permuatation
        end
        return x
    end

    function do_lu(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
        """
        DESC: Because LU decomposition was implemented in gauss:function,
        in order to LU decompose A, you only need to call gauss:function.

        A - matrix, type SparseMatrixCSC{Float64, Int64}.
        b - right side vector, type Vector{Float64}.
        n - size of the matrix.
        l - block size.

        OUT:
        A - matrix after Gauss elimination with done LU decomposition.
        b - vector accordingly changed after decomposition.
        """
        return gauss(A, b, n, l, true)
    end

    function do_lu_with_main_element(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
        """
        DESC: Because LU decomposition was implemented in gauss_choosing_main_element:function,
        in order to LU decompose A, you only need to call gauss_choosing_main_element:function.

        A - matrix, type SparseMatrixCSC{Float64, Int64}.
        b - right side vector, type Vector{Float64}.
        n - size of the matrix.
        l - block size.

        OUT:
        A - matrix after Gauss elimination with main element choosing andwith done LU decomposition.
        permutation - vector holding order of rows.
        b - vector accordingly changed after elimination.
        """
         return gauss_choosing_main_element(A, b, n, l, true)
    end

    function solve_lu(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
        """
        DESC: Standard way of calculating x in Ax = b, when A was LU decomposed.

        A - matrix, type SparseMatrixCSC{Float64, Int64}.
        b - right side vector, type Vector{Float64}.
        n - size of the matrix.
        l - block size.

        OUT:
        x - solution vector, type Vector{Float64}.
        """

        """ Part for changing b """
        modified_b = Vector{Float64}(undef, n) # for modified b
        for i = 1:n
            sum = Float64(0.0)

            for j = max(1, Int64(l * floor((i - 1) / l))):i - 1 # from Kincaid
                sum += A[j, i] * modified_b[j]
            end

            modified_b[i] = b[i] - sum
        end

        """ Part for calculating x """
        x = Vector{Float64}(undef, n) # answer vector
        for i = n:-1:1
            sum = Float64(0.0)

            for j = i + 1:min(n, i + l + 1)
                sum += A[j, i] * x[j]
            end
            x[i] = (modified_b[i] - sum) / A[i, i]
        end

        return x
    end

    function solve_lu_with_main_element(A::SparseMatrixCSC{Float64, Int64}, permutation::Vector{Int64},
                                                    b::Vector{Float64}, n::Int64, l::Int64)

        """
        DESC: Standard way of calculating x in Ax = b, after LU decomposition with choosing main element.

        A - matrix, type SparseMatrixCSC{Float64, Int64}.
        permutation - vector of size n holding order of rows.
        b - right side vector, type Vector{Float64}.
        n - size of the matrix.
        l - block size.

        OUT:
        x - solution vector, type Vector{Float64}.
        """

        """ Part for changing b """
        modified_b = Vector{Float64}(undef, n)
        for i = 1:n
            sum = Float64(0.0)

            for j = max(1, Int64(l * floor((i - 1) / l)) - 1):i - 1
                sum += A[j, permutation[i]] * modified_b[j]
            end

            modified_b[i] = b[permutation[i]] - sum
        end

        """ Part for calculating x """
        x = Vector{Float64}(undef, n)
        for i = n:-1:1
            sum = Float64(0.0)

            for j = i + 1:min(i + 2 * l + 1, n)
                sum += A[j, permutation[i]] * x[j]
            end

            x[i] = (modified_b[i] -  sum) / A[i, permutation[i]]
        end

        return x
    end

    function save_results_to_file(file_path::String, x::Vector{Float64}, n::Int64, vec_b_generated::Bool)
        """
        file_path - absolute path to the file from which matrix is supposed to be red.
        x - answer vector.
        n - matrix size.
        vec_b_generated - bool flag, if it is true relative error is being written to the file, else it is not.
        """
        open(file_path, "w") do file
            """ calculating error if b was generated """
            if vec_b_generated == true
                one = ones(n)

                err = norm(one - x) / norm(x)
                println(file, err)
            end

            for i = 1:n
                println(file, x[i])
            end
        end
    end

    function calculate_vector_b(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64)
        """
        DESC: If b was not read from the file it can be calculated.

        A - matrix, type SparseMatrixCSC{Float64, Int64}.
        n - size of the matrix.
        l - block size.

        OUT:
        b - calculated right side vector b, type Vector{Float64}.
        """
        b = Vector{Float64}(undef, n)

        for i = 1:n
            b[i] = Float64(0.0)

            for j = max(1, Int64(l * floor((i - 1) / l)) - 1):min(n, Int64(l + l * floor((i - 1) / l)))
                b[i] += A[j, i]
            end

            if i + l <= n
                b[i] += A[i, i + l]
            end
        end

        return b
    end
end

#
# A, n, l = read_matrix_from_file("/home/gabriel/Desktop/studia/rok 3/obliczenia_naukowe/lista_5/dane16/A.txt")
# A_sec, n, l = read_matrix_from_file("/home/gabriel/Desktop/studia/rok 3/obliczenia_naukowe/lista_5/dane16/A.txt")
#
# b, n = read_right_side_vector_from_file("/home/gabriel/Desktop/studia/rok 3/obliczenia_naukowe/lista_5/dane16/b.txt")
# b_sec, n = read_right_side_vector_from_file("/home/gabriel/Desktop/studia/rok 3/obliczenia_naukowe/lista_5/dane16/b.txt")
#
# new_b = calculate_vector_b(A, n, l)
# A1, perm,  b1 = do_lu_with_main_element(A,b,n,l)
# x = solve_lu_with_main_element(A1, perm, b1, n, l)
# A2, b2 = gauss(A_sec,b_sec,n,l, true)
# mat_1 = Matrix(A1)
# mat_2 = Matrix(A2)
# x = solve_gauss_with_main_element(A, b, n, l)
# save_results_to_file("/home/gabriel/Desktop/studia/rok 3/obliczenia_naukowe/lista_5/result.txt", x, n, false)
