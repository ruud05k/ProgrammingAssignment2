## Put comments here that give an overall description of what your
## functions do

# The 'makeCacheMatrix' function creates a function list, which effectively acts like an 'object' that provides access to the input matrix and its inverse matrix data. It is designed according to the object oriented programming paradigm (OOP): it contains functions to access and modify the data (generally referred to as 'information hiding' in OOP). (Although both matrices are actually not locally stored within this object itself, but in a higher environmental level, which is why the superassignment operator '<<-' needs to be called during the assignment procedures).

# The 'cacheSolve' function calculates and returns the inverse matrix from the matrix that is accessed by the 'makeCacheMatrix' return object. The 'makeCacheMatrix' return object should therefore be provided as an argument to the 'cacheSolve' function. If the inverse matrix was already calculated or set with the 'makeCacheMatrix' object, the calculation step is skipped and the cached matrix is returned instead.

# Usage example: 
# source("cachematrix.R")
# x <- matrix(c(1,2,3, 11.8,22,4,41,2.2,67), nrow = 3, ncol = 3, byrow = TRUE)  --> create example matrix
# cacheMatrix <- makeCacheMatrix(x)                                             --> create matrix object ('cacheMatrix') containing 
#                                                                                   the just created matrix
# cacheSolve(cacheMatrix)                                                       --> calculate inverse matrix, and store result in 'cacheMatrix'
# cacheMatrix$get() %*% cacheMatrix$getInvMatrix()                              --> verify that matrix multiplication of original and 
#                                                                                   inverse matrix results in identity matrix: A * A^(-1) = I
#                                                                                   = {{1,0,0},{0,1,0},{0,0,1}}

## Write a short comment describing this function
# See the explanation above on 'makeCacheMatrix'. Further, in this function the 'set' and 'setInv' functions set the matrix and inverse matrix in the upper-level environment, respectively, using superassignment. The 'get' and 'getInv' functions get the matrix and inverse matrix. A list is returned that contains the setter and getter functions, and can be thought of as an 'object' in the OOP paradigm, as explained above.

makeCacheMatrix <- function(x = matrix()) {
        xInv <- NULL

        set <- function(y) {
                x <<- y
                xInv <<- NULL
        }

        get <- function() {
		x
	}

        setInvMatrix <- function(invMatrix)  {
		xInv <<- invMatrix
	}

        getInvMatrix <- function() 
	{
		xInv
	}

        list(set = set, get = get,
             setInvMatrix = setInvMatrix,
             getInvMatrix = getInvMatrix)
}


## Write a short comment describing this function
# See the explanation above on 'cacheSolve'. This function uses the getter and setter functions from the 'makeCacheMatrix' object to access and modify the matrix data. As explained, if the inverse matrix was already calculated or set, this cached inverse matrix is returned. If not, the inverse matrix is directly calculated with the 'solve' function.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'

        xInv <- x$getInvMatrix()
        if(!is.null(xInv)) {
                message("getting cached data")
                return(xInv)
        }

	xInv <- solve(x$get())
        x$setInvMatrix(xInv)
        xInv
}



