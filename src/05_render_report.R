# src/05_render_report.R

if (!requireNamespace("rmarkdown", quietly = TRUE)) install.packages("rmarkdown")

rmarkdown::render(
  input = "report/solow_part1.Rmd",
  output_dir = "report",
  knit_root_dir = normalizePath(".")
)

message("✅ Output created: report/solow_part1.html")