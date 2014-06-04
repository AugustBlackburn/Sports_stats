odds<-function(w1,w2){
posterior_w<-(w1*(1-w2))/((w1*(1-w2))+(w2*(1-w1)))
return(posterior_w)
}
team1<-seq(0,1,by=0.01)
team2<-seq(0,1,by=0.01)
odds1<-NULL
odds2<-NULL
variable1<-NULL
for(i in 1:101){
	odd1<-team1[i]
	for(j in 1:101){
		odd2<-team2[j]
		new_odd<-odds(odd1,odd2)
		variable1<-append(variable1,new_odd)
		odds1<-append(odds1,odd1)
		odds2<-append(odds2,odd2)
	}
}
library(rgl)
plot3d(odds1,odds2,variable1,col="red")
