# to get histograms of numbers of links to each node
# for discussion question #12

# example values, for when not using in a function
nnodes=5
linkseach=3

staticrandomhist=function(nnodes, linkseach){
  network= staticrandom(nnodes,linkseach) 
  c = length(network[,1])
  b=sort(network)
  counts=array(dim=c)
  for (i in 1:c) {counts[i]=linkseach}
  for (i in 1:length(b)) {counts[b[i]] = counts[b[i]] + 1}
  #c
  #network
  #counts
  hist(counts,breaks=c((min(counts)-.5):(max(counts)+.5)))
	return(network)
}

# for getting histograms for growing random networks
# in question #13

growrandomhist=function(nnodes, linkseach){
  network= growrandom(nnodes,linkseach) 
  c = length(network[,1])
  b=sort(network)
  counts=array(dim=c)
	## next 2 lines are different from staticrandomhist
	counts[1]=0
  for (i in 2:c) {counts[i]=linkseach}
  for (i in 1:length(b)) {counts[b[i]] = counts[b[i]] + 1}
  #c
  #network
  #counts
  hist(counts,breaks=c((min(counts)-.5):(max(counts)+.5)))
	return(network)
}


