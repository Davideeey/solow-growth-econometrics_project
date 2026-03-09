# One-command pipeline
source("src/00_packages.R")
source("src/01_get_data.R")
source("src/02_clean_filter.R")
source("src/03_impute.R")
source("src/04_models_export.R")
source("src/05_render_report.R")
message("✅ Done. See report/ and results/.")
