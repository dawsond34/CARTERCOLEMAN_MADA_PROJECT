# UOWN Data Analysis for Determining Correlation Between Stream Health Indicators.
</br>
_The following markdown conducts the statistical analysis of how different indicators of stream health can potentially predict each other. In the previous processing script, the main take away was that there were very few significant relationships between different chemical, fecal/microbial and biological indicators. The only significant relationships found between Turbity and E. Coli CFU. However, It struck me as peculiar to see biological indicator score and conductivity to have only one significant relationship. After further review of the exploratory figures, I now want to assess the data and relationships explored thus far for impact of outliers, determine if it is appropriate to remove outlying values, and see if this helps find more significant relationships._
_The second part will include test/train splitting to predict stream health indicator values in the MIDO data set and assess the fit of linear models to the MIDO data. This is a more depth recreation of the linear model exploration. Obviously, we found that there weren't any significant relationships in exploratory analysis. However, this gives us a chance to assess how good a fit the models are in order to see if its even worth looking at the relationships._ 

</br>

_Therefore, the following constitutes the statistical analysis protocol that will be conducted in this markdown:_

</br>

#### PART 1: Outliers in stream health indicator (Biological Score, E. Coli (cfu), Conductivity, NO3 (mg/L), and Turbidity) linear relationships.
_1. Assess each linear relationship previously performed for outliers in the data;_
_2. Determine if it is appropriate to remove outliers;_
_3. Rerun linear regressions for the different stream health indicator relationships and assess if more significant relationships exist._

</br>

#### Part 2: Linear Model Fit Analysis of MIDO Data
_1. Conduct test/train data splitting for MIDO Data._
_2. Conduct linear modeling for relationships between stream health indicator predictors (Biological Score, E. Coli (cfu), Conductivity, NO3 (mg/L), and Turbidity) in the form of a workflow for the Test and Train MIDO data._
_3. Predict values for Test and Train MIDO data._
_4. Assess how well the MIDO linear model suite of relationships (Biological Score, E. Coli (cfu), Conductivity, NO3 (mg/L), and Turbidity) fir the test and train data using Root Mean Square Error (rmse). The result will measure how good of a fit the created models are to the data._

</br>

#### PART 3: LASSO Modeling MIDO Data
_Conduct LASSO modeling of linear regression between Biological Score and all other variables and E. coli CFU and all other variables. Cross validation well be done by calculating RMSE for all models and compared to the RMSE for linear regression modeling of a Null model. Additionally, The best model will be selected using the R function select_best(), for which residuals will be calculated between predicted and actual data._
