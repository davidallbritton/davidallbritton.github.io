# Copy and paste this document into R


#simulated diffusion model
dmsim=function(aa,vv,ter){
	n=4000
	heta=.1
	st=ter/5
#	sa=aa/5
	s=.025
	zz=aa/2
	sz=zz/5
	outp=matrix(data = NA, nrow = n, ncol = 2)
	for(i in 1:n){
#		a=runif(1,(aa-sa),(aa+sa))
		z=runif(1,(zz-sz),(zz+sz))
		drift=rnorm(1,vv,heta)
		t0=runif(1,(ter-st),(ter+st))
		outp[i,]=trial(aa,z,drift/100,s,t0)
	}
	return(c(mean(outp[,1]), mean(outp[,2]),  quantile(outp[outp[,1]==1,2],.1)))
}


trial=function(a,z,drift,s,t0){
	acc=z
	accl=z
	rtime=0
	response=c(3,0)
	while(acc > 0 & acc<a){
		rtime=rtime+1
		acc=acc+rnorm(1,drift,s)
		accl=c(accl,acc)
		if(acc>=a)response=c(1,rtime+t0)
		if(acc<=0)response=c(0,rtime+t0)
	}
	return(response)
#	return(accl)
#	plot(accl)
}



#
onetrial=function(a,z,drift,s,t0){
	acc=z
	accl=z
	rtime=0
	response=c(3,0)
	while(acc > 0 & acc<a){
		rtime=rtime+1
		acc=acc+rnorm(1,drift,s)
		accl=c(accl,acc)
		if(acc>=a)response=c(1,rtime+t0)
		if(acc<=0)response=c(0,rtime+t0)
	}
#	return(response)
	return(accl)
}


diffusion=function(a,z,drift){
   plot(onetrial(a,z,drift/100,.03,0),ylim=0:1,xlim=c(0,700),type="l",xlab="Time (ms)",ylab="")
}

