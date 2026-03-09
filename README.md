# Solow Growth Model (Part 1) — Reproducible Econometrics in R

This repo is the **Part 1 (baseline)** of my econometrics project testing Solow-style predictions using World Bank data:

- Higher **savings rate** is associated with higher **GDP per capita**.
- Higher **population growth** is associated with lower **GDP per capita**.

## Data
Data are pulled from the **World Bank** API via the `WDI` R package (no manual Excel downloads needed).

Indicators (codes):
- GDP per capita (current US$): `NY.GDP.PCAP.CD`
- Gross domestic savings (% of GDP): `NY.GDS.TOTL.ZS`
- Population growth (annual %): `SP.POP.GROW`

Sample period: **1982–2019**.

## Model (Part 1)
We estimate (log-log form):

\[ \log y_{it} = \alpha + \beta \log s_{it} + \gamma \log(n_{it}+g+\delta) + \varepsilon_{it} \]

Implementation detail:
- savings rate is converted from % to share: `s = savings_rate/100`
- population growth is converted from % to decimal: `n = pop_growth/100`
- we set `g + δ = 0.05` (configurable) and use `log(n + g + δ)` so we **do not need to drop negative population growth years**.

## How to run
In R from the repo root:

```r
source("run_all.R")
```

Outputs:
- Tables: `results/tables/`
- Figures: `results/figures/`
- Report: `report/solow_part1.html`

## Roadmap (Part 2)
- Panel estimators (country FE + year FE)
- Country-clustered SEs
- Additional sensitivity checks (PPP GDPpc, winsorization, subperiod stability)
