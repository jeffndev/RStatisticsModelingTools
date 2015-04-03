#SAMPLE from the following article on hand-doing markov and HMM models
#http://a-little-book-of-r-for-bioinformatics.readthedocs.org/en/latest/src/chapter10.html

states              <- c("AT-rich", "GC-rich") # Define the names of the states
ATrichprobs         <- c(0.7, 0.3)             # Set the probabilities of switching states, where the previous state was "AT-rich"
GCrichprobs         <- c(0.1, 0.9)             # Set the probabilities of switching states, where the previous state was "GC-rich"
thetransitionmatrix <- matrix(c(ATrichprobs, GCrichprobs), 2, 2, byrow = TRUE) # Create a 2 x 2 matrix
rownames(thetransitionmatrix) <- states
colnames(thetransitionmatrix) <- states

nucleotides         <- c("A", "C", "G", "T")   # Define the alphabet of nucleotides
ATrichstateprobs    <- c(0.39, 0.1, 0.1, 0.41) # Set the values of the probabilities, for the AT-rich state
GCrichstateprobs    <- c(0.1, 0.41, 0.39, 0.1) # Set the values of the probabilities, for the GC-rich state
theemissionmatrix <- matrix(c(ATrichstateprobs, GCrichstateprobs), 2, 4, byrow = TRUE) # Create a 2 x 4 matrix
rownames(theemissionmatrix) <- states
colnames(theemissionmatrix) <- nucleotides
theemissionmatrix              


nucleotides         <- c("A", "C", "G", "T") # Define the alphabet of nucleotides
afterAprobs <- c(0.2, 0.3, 0.3, 0.2)         # Set the values of the probabilities, where the previous nucleotide was "A"
afterCprobs <- c(0.1, 0.41, 0.39, 0.1)       # Set the values of the probabilities, where the previous nucleotide was "C"
afterGprobs <- c(0.25, 0.25, 0.25, 0.25)     # Set the values of the probabilities, where the previous nucleotide was "G"
afterTprobs <- c(0.5, 0.17, 0.17, 0.17)      # Set the values of the probabilities, where the previous nucleotide was "T"
mytransitionmatrix <- matrix(c(afterAprobs, afterCprobs, afterGprobs, afterTprobs), 4, 4, byrow = TRUE) # Create a 4 x 4 matrix
rownames(mytransitionmatrix) <- nucleotides
colnames(mytransitionmatrix) <- nucleotides
