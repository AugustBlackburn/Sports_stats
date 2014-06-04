### Some functions that are useful for sports stats
### Odds
odds<-function(p,q){
	posterior_w<-(p*(1-q))/((p*(1-q))+(q*(1-p)))
	return(posterior_w)
}
### Reverse_odds
reverse_odds<-function(x,q){
prob<-((q*x)/(1-q-x+(2*q*x)))
return(prob)
}

### Maximize_winning_percentage
maximize_winning_percentage<-function(iterations){
observed<-read.csv('parsed_NCAA_game_outcomes_2.csv',header=TRUE)
teams<-unique(observed$Team1)
true_wp<-NULL
for(i in 1:length(teams)){
	currteam<-observed[which(observed$Team1==teams[i]),]
	team_wp<-sum(currteam$Wins)/sum(currteam$Games)
	true_wp<-append(true_wp,team_wp)
}
original_wp<-true_wp
for(l in 1:iterations){
	hello<-head(observed)
	print(hello)
	flush.console()
	wp2<-true_wp
	wp<-NULL
	k<-1
	sos<-NULL
	for(i in 1:length(teams)){
		for( j in 1:length(teams)){	
			if(i==j){
				next
			}else{
				curr_sos<-wp2[j]
				sos<-append(sos,curr_sos)
			}
		}
	}
	observed$sos<-sos
	full_sos<-NULL
	team_sos_step1<-NULL
	for(i in 1:length(teams)){	
		currteam<-observed[which(observed$Team1==teams[i]),]
		#team_wp<-sum(currteam$Wins)/sum(currteam$Games)
		#wp<-append(wp,team_wp)
		team_sos_step2<-0
		for(j in 1:length(currteam$sos)){
			team_sos_step1<-currteam$sos[j]*currteam$Games[j]
			team_sos_step2<-team_sos_step2+team_sos_step1
		}
		team_sos<-team_sos_step2/sum(currteam$Games)
		full_sos<-append(full_sos,team_sos)
	}
	if(l==1){
		original_sos<-full_sos
	}
	print(l)
	print(full_sos)
	flush.console()
	k<-1
	expected<-NULL
	true_wp<-reverse_odds(original_wp,full_sos)
	print(true_wp)
	flush.console()
	m<-l
	wp_test1<-round(wp2,digits=4)
	wp_test2<-round(true_wp,digits=4)
	if(identical(wp_test1,wp_test2)){
	break
	}
}
wp<-NULL
print('Number of iterations to maximize')
print(m)
print('Original SOS')
print(original_sos)
print('Final SOS')
print(full_sos)
print('Change in SOS')
change_sos<-full_sos-original_sos
print(change_sos)
print('Original winning percentage')
print(original_wp)
print('Final winning percentage')
print(true_wp)
print('Change in WP')
change<-true_wp-original_wp
print(change)
flush.console()
pdf(file="Winning_percentage_adjusted_for_strength_of_schedule.pdf")
plot(original_wp,true_wp,xlim=c(0,1),ylim=c(0,1), xlab="Simple winning percentage", ylab="MLE winning percentage",main="Simple vs. MLE Winning Percentage")
abline(a=0,b=1)
dev.off()
pdf(file="Strength_of_schedule_adjusted.pdf")
plot(original_wp,true_wp,xlim=c(0,1),ylim=c(0,1), xlab="Simple strength of schedule", ylab="MLE strength of schedule",main="Simple vs. MLE Strength of Schedule")
abline(a=0,b=1)
dev.off()
Data<-data.frame(matrix(ncol=0,nrow=351))
Data$Teams<-teams
Data$SOS<-full_sos
Data$Original_SOS<-original_sos
Data$Change_in_SOS<-change_sos
Data$WP<-true_wp
Data$Original_WP<-original_wp
Data$Change_in_WP<-change
return(Data)
}

#Seven_game_winner
seven_game_winner<-function(team1,team2){
winner_odds<-odds(team1,team2)
x<-seq(0,7,1)
y<-dbinom(x,7,winner_odds)
plot(x,y)
series_odds<-sum(y[5:8])
return(series_odds)
}



	