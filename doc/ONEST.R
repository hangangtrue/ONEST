## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ONEST)

## -----------------------------------------------------------------------------
library(ONEST)
data("sp142_bin")


## -----------------------------------------------------------------------------
# figure(1): Plot of the agreement percentage in the order of columns in the inputs;
# figure(2): Plot of the 100 randomly chosen permutations;
# figure(3): Plot of the empirical confidence interval;
# figure(4): Barchart: the x axis is the case number and the Y axis is the number of pathologists that called that case positive, sorted from lowest to highest on the y axis;
# figure(5): Plot of the proportion of identical reads among a set of pathologists;
# figure(6): Plot of the difference between the proportion of identical reads among a set of pathologists;

# ONEST_main(sp142_bin)
data('empirical')
ONEST_vignettes(sp142_bin,empirical)

## -----------------------------------------------------------------------------
# (1) With example dataset sp263_bin:
# data("sp263_bin") ONEST_main(sp263_bin)

# (2) With example dataset NCNN_sp142:
# data("NCCN_sp142") ONEST_main(NCCN_sp142)

# (3) With example dataset NCNN_sp142_t:
# data("NCCN_sp142_t") ONEST_main(NCCN_sp142_t) 


