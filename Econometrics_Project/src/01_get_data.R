# Download World Bank data via WDI
# This replaces manual Excel downloads (more reproducible for GitHub).

dir.create("data_raw", showWarnings = FALSE)

start_year <- 1980
end_year   <- 2020

indicators <- c(
  gdp_pc_usd = "NY.GDP.PCAP.CD",
  savings_pct = "NY.GDS.TOTL.ZS",
  pop_growth_pct = "SP.POP.GROW"
)

raw <- WDI(
  country = "all",
  indicator = indicators,
  start = start_year,
  end = end_year,
  extra = TRUE,
  cache = NULL
)

raw <- raw %>%
  filter(region != "Aggregates") %>%
  select(iso3c, country, year, region, income, lending,
         gdp_pc_usd, savings_pct, pop_growth_pct)

write_csv(raw, "data_raw/wdi_raw.csv")
