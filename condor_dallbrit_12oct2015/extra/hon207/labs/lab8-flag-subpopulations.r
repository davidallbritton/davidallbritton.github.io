ECfindsubpops=function(M,L,generations,lb,ub,formula,mutrule,Delta,hardb,  nrepeat, fflag){
 # maxfitflag= cutoff value for fitness, below which will get your attention
# to flag simulations with 2 params that result in subpopulations
 nsims=0
 subpops=0
 for (k in 1:nrepeat) {
	fitnesstat=matrix(nrow=generations,ncol=3)
	population=matrix(runif((M*L), lb,ub),nrow=M,ncol=(L))
	fitmea=double(M)
	
	#fitness function for sims in section 1.3
	if(formula==1){
		fitmea=50-population[,1]^2
		typeof=1
	}
	#fitness function for sims in section 1.4
	if(formula==2){
		fitmea=population[,1]^2+population[,2]^2
		typeof=2
	}
	if(formula==3){
		fitmea=population[,1]^3
		typeof=1
	}
	if(formula==4){
		fitmea=sin(population[,1])
		typeof=1
	}
	if(formula==5){
		fitmea=population[,1]*sin(population[,1])
		typeof=1
	}
	if(formula==6){
		fitmea=population[,1]^2*population[,2]^3
		typeof=2
	}
	if(formula==7){
		fitmea=population[,1]*sin(population[,2])
		typeof=2
	}
	if(formula==8){
		fitmea=(population[,1]-2)*(population[,2]+5)
		typeof=2
	}
	if(formula==9){
		fitmea=population[,1]^2+rnorm(M,0,(population[,1]^2)/10)
		typeof=1
	}
	if(formula==10){
		fitmea=population[,1]^2
	    typeof=1
	}


	if(typeof==1)
		if(L!=1){
			print("You need to have exactly one trait to use this formula")
			break()
		}
	if(typeof==2)
		if(L!=2){
			print("You need to have exactly two traits to use this formula")
			break()
		}
	
	
	population=cbind(population, fitmea)

	for (j in 1:generations){
		##This loop is one generation
		for(k in 1:M){
			#Choose parent and member of pop to die (can2die)
			parent=trunc(runif(1,1,M+1))
			cand2die=trunc(runif(1,1,M+1))
			offspring=population[parent,]
			for(i in 1:L){
				if(runif(1)<(1/L)){
					# mutation rule +/- Delta
					if(mutrule==1){
						if(runif(1)<.5)
							offspring[i]=offspring[i]-Delta
						else
							offspring[i]=offspring[i]+Delta
						if(hardb==1){
							if(offspring[i]>ub) 
								offspring[i]=ub
							if(offspring[i]<lb) 
								offspring[i]=lb
						}
					}
					if(mutrule==2)
						offspring[i]=offspring[i]+rnorm(1,0,Delta)
						if(hardb==1){
							if(offspring[i]>ub) 
								offspring[i]=ub
							if(offspring[i]<lb) 
								offspring[i]=lb
						}
				}
			}
	
			if(formula==1){
				offspring[2]=50-offspring[1]^2
				if(population[cand2die,2] < offspring[2])
					population[cand2die,]=offspring				
			}
			if(formula==2){
				offspring[3]=offspring[1]^2+offspring[2]^2
				if(population[cand2die,3] < offspring[3])
					population[cand2die,]=offspring				
			}
			if(formula==3){
				offspring[2]=offspring[1]*offspring[1]*offspring[1]
				if(population[cand2die,2] < offspring[2])
					population[cand2die,]=offspring				
			}
			if(formula==4){
				offspring[2]=sin(offspring[1])
				if(population[cand2die,2] < offspring[2])
					population[cand2die,]=offspring
			}
			if(formula==5){
				offspring[2]=offspring[1]*sin(offspring[1])
				if(population[cand2die,2] < offspring[2])
					population[cand2die,]=offspring				
			}
			if(formula==6){
				offspring[3]=offspring[1]^2*offspring[2]^3
				if(population[cand2die,3] < offspring[3])
					population[cand2die,]=offspring				
			}
			if(formula==7){
				offspring[3]=offspring[1]*sin(offspring[2])
				if(population[cand2die,3] < offspring[3])
					population[cand2die,]=offspring				
			}
			if(formula==8){
				offspring[3]=(offspring[1]-2)*(offspring[2]+5)
				if(population[cand2die,3] < offspring[3])
					population[cand2die,]=offspring				
			}
			if(formula==9){
				offspring[2]=offspring[1]^2+rnorm(M,0,(offspring[1]^2)/10)
				if(population[cand2die,2] < offspring[2])
					population[cand2die,]=offspring				
			}
			if(formula==10){
				offspring[2]=offspring[1]^2
				if(population[cand2die,2] < offspring[2])
					population[cand2die,]=offspring				
			}

	

		}
		print(population)
		print(c("Average---min---max for generation",j))
		fitnesstat[j,1]=mean(population[,L+1])
		fitnesstat[j,2]=min(population[,L+1])
		fitnesstat[j,3]=max(population[,L+1])

		print(fitnesstat[j,])
#		readline("Press RETURN to continue")
	}
	plot(fitnesstat[,2],type='l',lty=2, xlab="Generation", ylab="fitness")
	lines(fitnesstat[,1],lty=1)
	lines(fitnesstat[,3],lty=3)

#check for subpopulations
      subpoptest=0
      for (jj in 1:L) {
         if ((sum(population[,jj]))**2 < (10*ub)**2) {subpoptest=1}
      }
      nsims=nsims+1
      subpops=subpops+subpoptest
      if (subpoptest > 0) {
          print(c("N simulations: ", nsims, " N subpops: ", subpops))
         if(fflag>0){ readline("Subpopulations found! Press RETURN to continue")}
      }
         
 }

 print (c("N simulations: ", nsims, " N subpopulations found: ", subpops))
}

# fixed delta
#ECfindsubpops(10,2,100,-5,5,2,1,1,1,  10, 0)
# Gaussian delta
#ECfindsubpops(10,2,100,-5,5,2,2,1,1,  10, 0)
# fixed delta, no hard bounds
#ECfindsubpops(10,2,100,-5,5,2,1,1,2,  100, 1)

