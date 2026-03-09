# Cleaning + sample rules

dir.create("data_processed", showWarnings = FALSE)

df <- read_csv("data_raw/wdi_raw.csv", show_col_types = FALSE)

# --- Config (Part 1) ---
start_year <- 1982
end_year   <- 2019
missing_threshold <- 0.90   # drop countries with >=90% missing in ANY key var

g_delta <- 0.05             # g + δ (standard Solow calibration)

# --- Restrict years ---
df <- df %>% filter(year >= start_year, year <= end_year)

# --- Country-level missingness filter ---
key_vars <- c("gdp_pc_usd", "savings_pct", "pop_growth_pct")
miss_by_cty <- df %>%
  group_by(iso3c) %>%
  summarise(across(all_of(key_vars), ~ mean(is.na(.x))), .groups = "drop") %>%
  mutate(max_missing = pmax(!!!rlang::syms(key_vars)))

keep_iso3c <- miss_by_cty %>%
  filter(max_missing < missing_threshold) %>%
  pull(iso3c)

df <- df %>% filter(iso3c %in% keep_iso3c)

# --- Variable construction (avoid dropping negative pop growth) ---
# Treat non-positive values as missing rather than deleting whole rows.
# This is safer before MI.

df <- df %>%
  mutate(
    y = ifelse(gdp_pc_usd > 0, gdp_pc_usd, NA_real_),
    s_share = ifelse(savings_pct > 0, savings_pct / 100, NA_real_),
    n = pop_growth_pct / 100,
    ngd = n + g_delta,
    ngd = ifelse(ngd > 0, ngd, NA_real_),

    log_y = log(y),
    log_s = log(s_share),
    log_ngd = log(ngd)
  )

write_csv(df, "data_processed/part1_clean.csv")
write_csv(miss_by_cty, "data_processed/missing_by_country.csv")
