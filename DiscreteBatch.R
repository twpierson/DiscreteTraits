#You can use code you wrote for the correlation exercise here.
source("DiscreteFunctions.R")
tree <- read.tree("____PATH_TO_TREE_OR_SOME_OTHER_WAY_OF_GETTING_A_TREE____")
discrete.data <- read.csv(file="____PATH_TO_DATA_OR_SOME_OTHER_WAY_OF_GETTING_TRAITS____", stringsAsFactors=FALSE) #death to factors.

cleaned.discrete <- CleanData(tree, discrete.data)

VisualizeData(tree, cleaned.discrete)

#First, let's use parsimony to look at ancestral states
cleaned.discrete.phyDat <- phyDat(cleaned.discrete, type="______________") #phyDat is a data format used by phangorn
anc.p <- ancestral.pars(tree, cleaned.discrete.phyDat)
plotAnc(tree, anc.p, 1)

#Do you see any uncertainty? What does that meean for parsimony?

#now plot the likelihood reconstruction
anc.ml <- ancestral.pml(pml(tree, cleaned.discrete.phyDat), type="ml")
plotAnc(tree, anc.ml, 1)

#How does this differ from parsimony? 
#Why does it differ from parsimony?
#What does uncertainty mean?

#How many changes are there in your trait under parsimony? 
parsimony.score <- ____some_function_____(tree, cleanded.discrete.phyDat)
print(parsimony.score)

#Can you estimate the number of changes under a likelihood-based model? 

#Well, we could look at branches where the reconstructed state changed from one end to the other. But that's not really a great approach: at best, it will underestimate the number of changes. A better approach is to use stochastic character mapping.

estimated.histories <- make.simmap(tree, cleaned.discrete, model="ARD", nsim=5)

#always look to see if it seems reasonable
plotSimmap(estimated.histories)

counts <- countSimmap(estimated.histories)
print(counts)