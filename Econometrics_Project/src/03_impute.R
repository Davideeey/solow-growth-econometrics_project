# Multiple imputation on transformed variables

set.seed(123)

df <- read_csv("data_processed/part1_clean.csv", show_col_types = FALSE)

# Keep only fields we want for MI / modeling
imp_df <- df %>%
  select(iso3c, year, region, income, lending, log_y, log_s, log_ngd)

# Convert identifiers to factors (predictors, not imputed)
imp_df <- imp_df %>%
  mutate(
    iso3c = as.factor(iso3c),
    region = as.factor(region),
    income = as.factor(income),
    lending = as.factor(lending)
  )

pred <- make.predictorMatrix(imp_df)

# Do not impute identifiers
pred[c("iso3c", "region", "income", "lending"), ] <- 0
pred[, c("iso3c", "region", "income", "lending")] <- 1  # allow them as predictors

meth <- make.method(imp_df)
meth[c("iso3c", "region", "income", "lending")] <- ""  # no imputation for these

imp <- mice(
  imp_df,
  m = 20,
  maxit = 20,
  method = meth,
  predictorMatrix = pred,
  printFlag = FALSE
)

saveRDS(imp, "data_processed/part1_mice.rds")
