library('testthat')

################################################################################
#
#  cachematrix.R
#
#  This program is used to compute the inverse of a matrix.  This operation can
#  take a long time to perform.  In order to mitigate this, upon computation,
#  the matrix inverse will be cached.  If the same matrix inversion is 
#  subsequently requested, the cached previously computed inversion will be 
#  returned rather that performing the time consuming computation again.
#
################################################################################

################################################################################
#
#  Name:    makeCacheMatrix
#
#  Purpose: The function handles cacheing matrix and matrix inverse.
#  
#  INPUT:   a matrix or none (matrix can be set later)
#  OUTPUT:  a list of functions which perform the following operations:
#
#       set(y)     - set cached matrix to x; clear matrix inverse cache
#       get()      - get cached matrix
#       setinv(z)  - set cached matrix inverse to y
#       getinv()   - get cached matrix inverse - NULL if cache is clear
#
################################################################################

makeCacheMatrix <- function(x = matrix()) {

}

################################################################################
#
#  Name:    cacheSolve
#
#  Purpose: Compute matrix inverse ONLY if inverse is uncached for input matrix
#  
#  INPUT:   a makeCachedMatrix function
#  OUTPUT:  the matrix inverse
#
################################################################################

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
}

################################################################################
#
#  The main program runs a set of informal tests first and then applies unit 
#  tests.
#
################################################################################

test_dir('tests', reporter = 'Summary')