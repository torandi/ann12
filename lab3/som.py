import numpy
import animals as a
w = appropriatelySizedMatrixOfRandomNumbers
for nbh in listOfNeighborhoodSizes:
    #Loop through the dataset
    for x in a.animals:
        #Difference between x and all prototype vectors
        diff= a.props[x] - w
        #Calculate sum of square d differences
        #for all prototypes simultaneously
        dist=numpy.sum(diff*diff,axis=1)
        #Locate the winner (index to smallest distance)
        winner=numpy.argmin(dist)
        #Fill in code to find the neighbordhood here
        #Update weights of all nodes in the neighborhood
        for i in theNeighborhood:
            w[i]+=diff[i]*0.2
