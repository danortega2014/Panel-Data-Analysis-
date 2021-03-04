# Panel-Data-Regression
Panel Data Regression models UN general assembly data from https://www.kaggle.com/unitednations/general-assembly

Panel data is essentially cross sectional data but rather than sampled once, it is sampled many times adding a time aspect to the data that can be controlled for as well as group variables (in this case nations). Controlling for time can allow the ability to see variables that change over time but are constant amongst certain groups. 

This code compares three panel data regression techniques: Pooled OlS, Fixed Effects, and Random Effects.

----



Imputed all NA's with averages 
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

1.) Pooled OLS
Simple OLS regression that ignores the time and group aspect of the data.
```
pooled = lm(no_votes~yes_votes+abstain+idealpoint_estimate+affinityscore_usa+affinityscore_brazil+affinityscore_china+affinityscore_india
+affinityscore_israel+affinityscore_russia,data=paneldata)
```
Fixed 

2.) Fixed Effects
Takes into consideration group variable

3.) Random Effects
Takes into consideration group and time variabes eliminating bias from unobserved time related factors. 
