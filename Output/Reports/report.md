TITLE HERE
================
2026-08-17

- [Initial Replicate](#initial-replicate)
- [Experimental Data](#experimental-data)

## Initial Replicate

This replicate used the lab culture from Centennial Park, collected
during Summer 2025.

``` r

prelim_data %>% 
  drop_na() %>% 
  ggplot(aes(x = treatment, y = ctmax)) + 
  geom_boxplot() +
  geom_point() + 
  ylim(35.5,37.5) + 
  labs(x = "Treatment", 
       y = "CTmax (°C)") + 
  theme_matt()
```

<img src="../Figures/markdown/prelim-boxplots-1.png" style="display: block; margin: auto;" />

## Experimental Data

``` r

ctmax_data %>% 
  ggplot(aes(x = treatment, y = ctmax)) + 
  geom_boxplot() +
  geom_point() + 
  labs(x = "Treatment", 
       y = "CTmax (°C)") + 
  theme_matt()
```

<img src="../Figures/markdown/ctmax-boxplots-1.png" style="display: block; margin: auto;" />
