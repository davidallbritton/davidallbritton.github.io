input=array(dim=4)
hidden=array(dim=3)
output=array(dim=4)
hnet=hidden
onet=output
stimuli=rbind(c(1,0,0,0),c(0,1,0,0),c(0,0,1,0),c(0,0,0,1),c(1,1,1,1), c(0,1,1,0))
lr=4
wih=matrix(runif(12,-.3,.3),ncol=3,nrow=4) 
oih=dih=matrix(rep(0,12),ncol=3,nrow=4) 
who=matrix(runif(12,-.3,.3),ncol=4,nrow=3) 
oho=dho=matrix(rep(0,12),ncol=4,nrow=3) 
mathc=0
deltao=c(0, 0, 0, 0)
deltah=c(0, 0, 0)

#teach first 3 patterns
while(mathc<11.7){
	mathc=0
	for(k in 1:3){
	teach=stimuli[k,]
	input=teach
#	print(input)
#	print(teach)
	for (i in 1:3){
      		hnet[i]=sum(wih[,i]*input)
      		hidden[i]=1/(1+exp(-hnet[i]))
	}
	for (i in 1:4){
    		onet[i]=sum(who[,i]*hidden)
      		output[i]=1/(1+exp(-onet[i]))
	}

	deltao=(teach-output)*output*(1-output)
	for(i in 1:4){
    		for(j in 1:3){
					dho[j,i]=lr*deltao[i]*hidden[j]
        			who[j,i]=who[j,i]+dho[j,i]+oho[j,i]*.5
					oho[j,i]=dho[j,i]
    		}
	}
	
	for (i in 1:3){
   		deltah[i]=hidden[i]*(1-hidden[i])*sum(deltao*who[i,])
	}
	
	for(i in 1:3){
    		for(j in 1:4){
					dih[j,i]=lr*deltah[i]*input[j]
        			wih[j,i]=wih[j,i]+dih[j,i]+oih[j,i]*.5
					oih[j,i]=dih[j,i]
    		}
	}
	print(round(output,2))
	mathc=mathc+sum(((2*output)-1)*((2*teach)-1))
  }
  print(mathc)
}
readline("First three patterns learnt\n Press enter to learn next pattern")
#teach last pattern
mathc=0
while(mathc<3.85){
	mathc=0
	for(k in 4:4){
	teach=stimuli[k,]
	input=teach
#	print(input)
#	print(teach)
	for (i in 1:3){
      		hnet[i]=sum(wih[,i]*input)
      		hidden[i]=1/(1+exp(-hnet[i]))
	}
	for (i in 1:4){
    		onet[i]=sum(who[,i]*hidden)
      		output[i]=1/(1+exp(-onet[i]))
	}

	deltao=(teach-output)*output*(1-output)
	for(i in 1:4){
    		for(j in 1:3){
					dho[j,i]=lr*deltao[i]*hidden[j]
        			who[j,i]=who[j,i]+dho[j,i]+oho[j,i]*.5
					oho[j,i]=dho[j,i]
    		}
	}
	
	for (i in 1:3){
   		deltah[i]=hidden[i]*(1-hidden[i])*sum(deltao*who[i,])
	}
	
	for(i in 1:3){
    		for(j in 1:4){
					dih[j,i]=lr*deltah[i]*input[j]
        			wih[j,i]=wih[j,i]+dih[j,i]+oih[j,i]*.5
					oih[j,i]=dih[j,i]
    		}
	}
	print(round(output,2))
	mathc=mathc+sum(((2*output)-1)*((2*teach)-1))
  }
  print(mathc)
}
readline("Final patterns learnt\n Press enter to begin test")


## test
for(k in 1:6){
    mathc=0
	teach=stimuli[k,]
	input=teach
#	print(input)
	print(c("input :",round(teach,2)))
	for (i in 1:3){
      		hnet[i]=sum(wih[,i]*input)
      		hidden[i]=1/(1+exp(-hnet[i]))
	}
	for (i in 1:4){
    		onet[i]=sum(who[,i]*hidden)
      		output[i]=1/(1+exp(-onet[i]))
	}

  print(c("output:",round(output,2)))
  mathc=mathc+sum(((2*output)-1)*((2*teach)-1))
  
  print(c("Match (dot product) = ", mathc))
}



