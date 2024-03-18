#survey3
#https://epirhandbook.com/en/survey-analysis.html
## load packages from CRAN
pacman::p_load(
  rio,          # File import
  here,         # File locator
  tidyverse,    # data management + ggplot2 graphics
  tsibble,      # handle time series datasets
  survey,       # for survey functions
  srvyr,        # dplyr wrapper for survey package
  gtsummary,    # wrapper for survey package to produce tables
  apyramid,     # a package dedicated to creating age pyramids
  patchwork,    # for combining ggplots
  ggforce       # for alluvial/sankey plots
) 

## load packages from github
pacman::p_load_gh(
  "R4EPI/sitrep" # for observation time / weighting functions
)

#data----
# import the survey data
survey_data <- rio::import("survey_data.xlsx")
survey_data
# import the dictionary into R
survey_dict <- rio::import("survey_dict.xlsx") 

# import the population data
population <- rio::import("population.xlsx")

## define the number of households in each cluster
cluster_counts <- tibble(cluster = c("village_1", "village_2", "village_3", "village_4", "village_5", "village_6", "village_7", "village_8", "village_9", "village_10"), households = c(700, 400, 600, 500, 300,  800, 700, 400, 500, 500))