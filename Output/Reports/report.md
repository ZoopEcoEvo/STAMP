TITLE HERE
================
2026-08-09

- [Initial Replicate](#initial-replicate)

## Initial Replicate

This replicate used the lab culture from Centennial Park, collected
during Summer 2025.

``` r

ctmax_data %>% 
  drop_na() %>% 
  ggplot(aes(x = treatment, y = ctmax)) + 
  geom_boxplot() +
  geom_point() + 
  ylim(35.5,37.5) + 
  labs(x = "Treatment", 
       y = "CTmax (°C)") + 
  theme_matt()
```

<img src="../Figures/markdown/ctmax-boxplots-1.png" style="display: block; margin: auto;" />

``` r

ctmax.model = lmer(data = ctmax_data, 
                   ctmax ~ treatment + (1|assay) + (1|tube))

#performance::check_model(ctmax.model)

summary(ctmax.model)
## Linear mixed model fit by REML. t-tests use Satterthwaite's method ['lmerModLmerTest']
## Formula: ctmax ~ treatment + (1 | assay) + (1 | tube)
##    Data: ctmax_data
## 
## REML criterion at convergence: 11.8
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -2.0991 -0.5634  0.1256  0.5577  1.4295 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev.
##  tube     (Intercept) 0.009052 0.09514 
##  assay    (Intercept) 0.022272 0.14924 
##  Residual             0.052293 0.22868 
## Number of obs: 27, groups:  tube, 9; assay, 4
## 
## Fixed effects:
##                        Estimate Std. Error       df t value Pr(>|t|)    
## (Intercept)            36.44255    0.12133  6.72688 300.362 3.88e-15 ***
## treatmentMicroplastics  0.05903    0.12981 18.19749   0.455   0.6547    
## treatmentHeatwave       0.02213    0.13211 16.64809   0.167   0.8690    
## treatmentCombined       0.24213    0.12761 17.12380   1.897   0.0748 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Correlation of Fixed Effects:
##             (Intr) trtmnM trtmnH
## trtmntMcrpl -0.529              
## tretmntHtwv -0.452  0.429       
## trtmntCmbnd -0.528  0.500  0.450

car::Anova(ctmax.model)
## Analysis of Deviance Table (Type II Wald chisquare tests)
## 
## Response: ctmax
##           Chisq Df Pr(>Chisq)
## treatment 4.337  3     0.2273
```
