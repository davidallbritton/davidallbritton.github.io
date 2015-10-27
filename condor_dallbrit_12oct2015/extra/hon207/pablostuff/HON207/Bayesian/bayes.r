#
#  Copy and paste this code into the R command prompt
#  or put this file in the R working directory and type
#  > source('bayes.r')  at the command prompt
#  or copy and paste 
#
#  This is the code need for the bayesian perception lab

drawproj=function(theta,spin){
	thetaa=(90-theta/2)*(pi/180)
	yo=(tan(thetaa)*100)
	plot(-100:100,-100:100, type="n")
	lines(c(-100,100),c(-yo,yo))
	lines(c(100,-100),c(-yo,yo))

    proj=sin(spin*(pi/180))*yo
    
    lines(c(-100,100),c(-proj,proj),lwd=2)
	lines(c(100,-100),c(-proj,proj),lwd=2)
	phi=180-2*atan(proj/100)*180/pi
	text(0,50,phi)

}



thetas=matrix(ncol=4,nrow=5000)
thetas[,1]=runif(5000,0,180)
thetas[,2]=rnorm(5000,90,30)
for(i in 1:5000){
	while(thetas[i,2]<0 || thetas[i,2]>180){
		thetas[i,2]=rnorm(1,90,30)
	}
}
thetas[,3]=rnorm(5000,90,10)
for(i in 1:5000){
	while(thetas[i,3]<0 || thetas[i,3]>180)
		thetas[i,3]=rnorm(1,90,10)
}
thetas[,4]=c(rgeom(2500,.05),180-rgeom(2500,.05))
for(i in 1:5000){
	while(thetas[i,4]<0)
		thetas[i,4]=180-rgeom(1,.05)
	while(thetas[i,4]>180)
		thetas[i,4]=rgeom(1,.05)
}

bayesper=function(obs,prior){
	likeli=obs
	for (i in 1:100000){
		spin=runif(1,0,90)
		theta=thetas[trunc(runif(1,1,5000)),prior]
		thetaa=(90-theta/2)*(pi/180)
		yo=(tan(thetaa)*100)
		proj=sin(spin*(pi/180))*yo
		phi=180-2*atan(proj/100)*180/pi
		if((obs-phi)^2<1){
			likeli=c(likeli,theta)
		}
	}
#	return(trunc(likeli))
	hist(likeli, probability=T,xlim=c(0,180))		
}

