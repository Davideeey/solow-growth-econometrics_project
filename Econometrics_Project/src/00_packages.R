# Install/load packages (kept minimal and explicit)
req <- c(
  "WDI", "dplyr", "readr", "tidyr",
  "mice", "broom", "sandwich", "lmtest",
  "ggplot2", "rmarkdown"
)

for (p in req) {
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
}

library(WDI)
library(dplyr)
library(readr)
library(tidyr)
library(mice)
library(broom)
library(sandwich)
library(lmtest)
library(ggplot2)
library(rmarkdown)
