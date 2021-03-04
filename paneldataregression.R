
library(readxl)
paneldata <- read_excel("C:/Users/danor/Desktop/UN General Assembly Voting data.xltx")
View(UN_General_Assembly_Voting_data)

attach(paneldata)

library(lmtest)
library(foreign)
library(lmtest)

#imputing all numerical column variables with averages
abstain[is.na(abstain) ] <- mean(abstain, na.rm = TRUE)
yes_votes[is.na(yes_votes) ] <- mean(yes_votes, na.rm = TRUE)   
no_votes [is.na(no_votes ) ] <- mean(no_votes , na.rm = TRUE)   
idealpoint_estimate[is.na(idealpoint_estimate) ] <- mean(idealpoint_estimate, na.rm = TRUE)   
affinityscore_usa[is.na(affinityscore_usa) ] <- mean(affinityscore_usa, na.rm = TRUE)   
affinityscore_russia[is.na(affinityscore_russia) ] <- mean(affinityscore_russia, na.rm = TRUE)   
affinityscore_israel[is.na(affinityscore_israel) ] <- mean(affinityscore_israel, na.rm = TRUE)   
affinityscore_china[is.na(affinityscore_china) ] <- mean(affinityscore_china, na.rm = TRUE)   
affinityscore_brazil[is.na(affinityscore_brazil) ] <- mean(affinityscore_brazil, na.rm = TRUE)   
affinityscore_india[is.na(affinityscore_india) ] <- mean(affinityscore_india, na.rm = TRUE)   


pooled = lm(no_votes~yes_votes+abstain+idealpoint_estimate+affinityscore_usa+affinityscore_brazil+affinityscore_china+affinityscore_india
+affinityscore_israel+affinityscore_russia,data=paneldata)
summary(pooled)

Pooled2=plm(no_votes~yes_votes+abstain+idealpoint_estimate+affinityscore_usa+affinityscore_brazil+affinityscore_china+affinityscore_india
            +affinityscore_israel+affinityscore_russia+factor(year),data=paneldata,index=c("state_name","year"),model='pooling')
summary(Pooled2)

coeftest(Pooled2,vcov.=vcovHC,cluster="time") #Cluster-robust standard errors: cluster by country


#Fixed Effects

fixedeffects = plm(no_votes~yes_votes+abstain+idealpoint_estimate+affinityscore_usa+affinityscore_brazil+affinityscore_china+affinityscore_india
        +affinityscore_israel+affinityscore_russia,data=paneldata,index=c("state_name","year"),model='within')
summary(fixedeffects)

olscountrydv =lm(no_votes~yes_votes+abstain+idealpoint_estimate+affinityscore_usa+affinityscore_brazil+affinityscore_china+affinityscore_india
      +affinityscore_israel+affinityscore_russia+factor(state_name),data=paneldata)
summary(olscountrydv)



randomeffects=plm(no_votes~yes_votes+abstain+idealpoint_estimate+affinityscore_usa+affinityscore_brazil+affinityscore_china+affinityscore_india
                  +affinityscore_israel+affinityscore_russia,data=paneldata,index=c("state_name","year"),model='random')
summary(randomeffects)


randomeffect2 =plm(no_votes~yes_votes+abstain+idealpoint_estimate+affinityscore_usa+affinityscore_brazil+affinityscore_china+affinityscore_india
        +affinityscore_israel+affinityscore_russia,data=paneldata,index=c("state_name","year"),effect="time",model='random')
summary(randomeffect2)
