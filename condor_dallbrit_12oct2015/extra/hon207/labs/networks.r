# lab7: networks

staticrandom=function(Nc, nlink){
  #static random
  srnd=matrix(ncol=nlink,nrow=Nc)
  for(i in 1:Nc) {
	  for(j in 1:nlink) {
		  srnd[i,j]=i
		  #put it in a loop, because a node can not link to itself
		  while(srnd[i,j]==i){
			  srnd[i,j]=trunc(runif(1,1,Nc+1))
		  }
	  }
  }
  return(srnd)
}

growrandom=function(Nc, nlink){ 
  #dynamic random
  drnd=matrix(ncol=nlink,nrow=Nc)
  #drnd[1,]=rep(1,nlink)
  for(i in 1:Nc){
	  if (i>1){
		  drnd[i,]=trunc(runif(nlink,1,i))
	  }
  }
  return(drnd)
}