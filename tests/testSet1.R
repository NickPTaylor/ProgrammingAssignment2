################################################################################
#
#  Unit Testing    
#
#  This is the unit test suite for cachematrix.R
#
################################################################################

# test parameters
set.seed(1)
mat.1 <- matrix(runif(100), 10, 10)
inv.1 <- solve(mat.1)

set.seed(2)
mat.2 <- matrix(runif(100), 10, 10)
inv.2 <- solve(mat.2)

context("Tests for makeCacheMatrix function")

test_that("correctly instantiated with matrix", {
    mcm.instance <- makeCacheMatrix(mat.1)
    expect_that(mcm.instance$get(), is_identical_to(mat.1))
    expect_that(mcm.instance$getinv(), is_identical_to(NULL))
})

test_that("correctly instantiated with default", {
    mcm.instance <- makeCacheMatrix()
    expect_that(mcm.instance$get(), is_a("matrix"))
    expect_that(mcm.instance$getinv(), is_identical_to(NULL))
})

test_that("setting inverse", {
    mcm.instance <- makeCacheMatrix(mat.1)
    mcm.instance$setinv(inv.1)
    expect_that(mcm.instance$getinv(), is_identical_to(inv.1))
})

test_that("cache is cleared upon reset", {
    mcm.instance <- makeCacheMatrix(mat.1)
    mcm.instance$setinv(inv.1)
    expect_that(mcm.instance$getinv(), is_identical_to(inv.1))
    mcm.instance <- makeCacheMatrix(mat.2)
    expect_that(mcm.instance$getinv(), is_identical_to(NULL))    
})

context("Tests for cacheSolve function")

test_that("inverse is returned for new makeCacheMatrix instance", {
    
    mcm.instance.1 <- makeCacheMatrix(mat.1)
    expect_that(comp.1 <- cacheSolve(mcm.instance.1), 
                shows_message("calculating inverse"))
    expect_that(comp.1, is_identical_to(inv.1))
    
    mcm.instance.2 <- makeCacheMatrix(mat.2)
    expect_that(comp.2 <- cacheSolve(mcm.instance.2), 
                shows_message("calculating inverse"))
    expect_that(comp.2, is_identical_to(inv.2))
})

test_that("cache is used if inverse has already been calculated", {
    
    mcm.instance.1 <- makeCacheMatrix(mat.1)
    expect_that(comp.1 <- cacheSolve(mcm.instance.1), 
                shows_message("calculating inverse"))
    expect_that(comp.1, is_identical_to(inv.1)) 
    expect_that(comp.2 <- cacheSolve(mcm.instance.1), 
                                        shows_message("getting cached data"))
    expect_that(comp.2, is_identical_to(inv.1))    
})
