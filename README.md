# Panel-Data-Regression
Panel Data Regression models UN general assembly data from https://www.kaggle.com/unitednations/general-assembly

Panel data is essentially cross sectional data but rather than sampled once, it is sampled many times adding a time aspect to the data that can be controlled for as well as group variables (in this case nations). Controlling for time can allow the ability to see variables that change over time but are constant amongst certain groups. 

This code compares three panel data regression techniques: Pooled OlS, Fixed Effects, and Random Effects.

----
# Data Description
![image](https://user-images.githubusercontent.com/64437206/110016169-55e20780-7cea-11eb-80fd-8c46a426b9fa.png)



Lots of missing values in this data so I imputed all NA's with averages for the continuous variables. Excluded the missing values for categorical variable years in excel. 
```
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

```

# 1.) Pooled OLS
Simple OLS regression that ignores the time and group aspect of the data.
```
pooled = lm(no_votes~yes_votes+abstain+idealpoint_estimate+affinityscore_usa+affinityscore_brazil+affinityscore_china+affinityscore_india
+affinityscore_israel+affinityscore_russia,data=paneldata)

summary(pooled)
```
![image](https://user-images.githubusercontent.com/64437206/110038333-373d3a00-7d05-11eb-89e0-b0f9a645ec04.png)

.65  adjusted  r-squared, can be better with time dummy variables.
```
#Pooled OLS estimator with time dummies:
Pooled2=plm(no_votes~yes_votes+abstain+idealpoint_estimate+affinityscore_usa+affinityscore_brazil+affinityscore_china+affinityscore_india
            +affinityscore_israel+affinityscore_russia+factor(year),data=paneldata,index=c("state_name","year"),model='pooling')
summary(Pooled2)
```
![image](https://user-images.githubusercontent.com/64437206/110038688-b0d52800-7d05-11eb-859c-c0f11cb0a728.png)

There were a lot of significant years that affected the number of no votes. Adjusted R-squared increased to .75, meaning 75% of the variation of no_votes is explained by the model.
```
# You can also you need this function to get cluster robust standard errors clustered by time. (can be group or both)
coeftest(Pooled2,vcov.=vcovHC,cluster="time")
```

Fixed 

# 2.) Fixed Effects
Takes into consideration group variable
```
fixedeffects =plm(no_votes~yes_votes+abstain+idealpoint_estimate+affinityscore_usa+affinityscore_brazil+affinityscore_china+affinityscore_india
        +affinityscore_israel+affinityscore_russia,data=paneldata,index=c("state_name","year"),model='within')
summary(fixedeffects)
```
![image](https://user-images.githubusercontent.com/64437206/110040484-85a00800-7d08-11eb-82f3-fc37cfed1b97.png)

Pretty low R-squared of .27, this is most likely ddue to  missing important time related factors.

OlS with dummy variables for country

```
olscountrydv =lm(no_votes~yes_votes+abstain+idealpoint_estimate+affinityscore_usa+affinityscore_brazil+affinityscore_china+affinityscore_india
      +affinityscore_israel+affinityscore_russia+factor(state_name),data=paneldata)
summary(olscountrydv)
```
![image](https://user-images.githubusercontent.com/64437206/110040603-b2ecb600-7d08-11eb-9d5a-2bd85ac4489b.png)
Actually performs quite well with an adjusted R-squared of .786.

# 3.) Random Effects

Takes into consideration group and time variabes eliminating bias from unobserved time related factors. 
