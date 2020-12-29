using SparseArrays

function read_matrix_from_file(file_path::String)
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
    permutation = Vector{Int64}(undef, n)

    # initializing permutation vector
    for i = 1:n
        permutation[i] = i
    end

    for k = 1:n-1 # k is for columns
        how_many_to_eliminate = k + (l - k % l) # optimazing
        max_row = k # max_row is for finding max element
        max_element = abs(A[k, k]) # variable for biggest element in columns

        for i = k:how_many_to_eliminate
            if abs(A[k, permutation[i]]) > max_element
                max_element = abs(A[k, permutation[i]])
                max_row = i
            end
        end

        permutation[k], permutation[max_row] = permutation[max_row], permutation[k]

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
    A, permutation, b = gauss_choosing_main_element(A, b, n, l, false)

    #Vector with solutions of equations set
    x = Vector{Float64}(undef, n)

    for i = n:-1:1 # i is for rows
        sum = Float64(0.0)
        for j = i + 1:min(i + 2 * l + 1, n) # j is for columns
            sum += A[j, permutation[i]] * x[j]
        end

        x[i] = (b[permutation[i]] - sum) / A[i, permutation[i]]
    end
    return x
end

A, n, l = read_matrix_from_file("/home/gabriel/Desktop/studia/rok 3/obliczenia_naukowe/lista_5/dane16/A.txt")
b, n = read_right_side_vector_from_file("/home/gabriel/Desktop/studia/rok 3/obliczenia_naukowe/lista_5/dane16/b.txt")
# mat = Matrix(A)
# x = A[1,2]
# println(x)
# A1, nothi1 = gauss(A, b, n ,l, false)
# mat1 = Matrix(A1)
# A2, nothi2 = gauss(A, b, n ,l, true)
# mat2 = Matrix(A2)
# x = solve_gauss(A, b, n, l)
# mat = Matrix(A)
# x = A[1,2]
# println(x)
# A1, nothi1 = gauss_choosing_main_element(A, b, n ,l, false)
# mat1 = Matrix(A1)
# A2, nothi2 = gauss(A, b, n ,l, true)
# mat2 = Matrix(A2)
x = solve_gauss_with_main_element(A, b, n, l)
