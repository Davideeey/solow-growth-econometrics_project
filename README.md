# Solow Growth Econometrics (Part 1)

Reproducible econometrics project testing Solow-style predictions using World Bank data:

- Higher savings (investment) is associated with higher GDP per capita.
- Higher population-growth term is associated with lower GDP per capita.

Part 1 uses a pooled log-log specification, multiple imputation for missing values, and a complete-case robustness check with HC3 robust standard errors.

---

## Repository structure

Project files are inside the folder:

- `Econometrics_Project/`

Main contents (inside that folder):

- `run_all.R` — runs the full pipeline
- `src/` — scripts (download, clean, impute, estimate, render report)
- `report/` — R Markdown report and rendered HTML
- `results/`
  - `results/tables/` — exported regression tables (CSV)
  - `results/figures/` — exported figures (PNG)

---

## Requirements

- R
- RStudio (recommended)

Packages are installed automatically by the scripts when needed.

---

## How to run

### RStudio (recommended)
1. Open RStudio
2. Set your working directory to the project folder (`Econometrics_Project/`)
3. Run:

```r
setwd("Econometrics_Project")
source("run_all.R")
```
or

### Terminal
From the repository root:

```bash
Rscript Econometrics_Project/run_all.R
```

---

## Output files

After running, you should get:

- Report:
  - `Econometrics_Project/report/solow_part1.html`
- Tables:
  - `Econometrics_Project/results/tables/mi_main.csv`
  - `Econometrics_Project/results/tables/complete_case_hc3.csv`
- Figure:
  - `Econometrics_Project/results/figures/resid_vs_fitted.png`

---

## Data source

Data are downloaded automatically from the World Bank API during execution (no manual download needed).

---

## Notes

- Results in Part 1 are associations from a pooled specification.
- Part 2 (planned): panel structure (country/year fixed effects), clustered standard errors, additional robustness checks.
