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

makeCacheMatrix <- function(cached.mat = matrix()) {
    
    # initialise cache each time function is invoked
    cached.inv <- NULL
    
    # if cached matrix is reset, clear cache
    set <- function(x) {
        cached.mat <<- x               
        cached.inv <<- NULL
    }
    
    get <- function() cached.mat
    setinv <- function(y) cached.inv <<- y
    getinv <- function() cached.inv
    
    # return list of functions
    list(set = set, 
         get = get,
         setinv = setinv,
         getinv = getinv)
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
    
    # get cached matrix inverse if it exists ...
    inv <- x$getinv()
    if(!is.null(inv)) {
        message("getting cached data")
        return(inv)
    }
    else {
        message("calculating inverse")
    }
    
    # ... otherwise get cached matrix, compute inverse and cache that also.
    data <- x$get()
    inv <- solve(data, ...)
    
    x$setinv(inv)
    # on any account, return the inverse
    inv
}

################################################################################
#
#  The main program displays a set of informal tests first and then applies unit 
#  tests which can be found in the 'tests' folder on the GitHub remote repo.
#
################################################################################

set.seed(0)                                 # set seed for repeatable results
test.mat = matrix(rnorm(9), 3, 3)           # make test matrix
test.cache = makeCacheMatrix(test.mat)      # make test cache
print(cacheSolve(test.cache))               # pass cache, print result
print(cacheSolve(test.cache))               # should retrieve from cache
test.cache = makeCacheMatrix(test.mat)      # reset
print(cacheSolve(test.cache))               # should recalculate

# unit testing
cat("\nUnit Testing:\n\n")
test_file('tests/testSet1.R')