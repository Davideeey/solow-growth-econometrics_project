# Estimate models + export tables

dir.create("results/tables", recursive = TRUE, showWarnings = FALSE)
dir.create("results/figures", recursive = TRUE, showWarnings = FALSE)

imp <- readRDS("data_processed/part1_mice.rds")

# MI (Rubin pooling)
fit_mi <- with(imp, lm(log_y ~ log_s + log_ngd))
mi_sum <- summary(pool(fit_mi), conf.int = TRUE)
write_csv(mi_sum, "results/tables/mi_main.csv")

# Complete-case robustness + HC3 robust SE
cc <- complete(imp, 1) %>%
  select(log_y, log_s, log_ngd) %>%
  drop_na()

m_cc <- lm(log_y ~ log_s + log_ngd, data = cc)

hc3 <- coeftest(m_cc, vcov. = vcovHC(m_cc, type = "HC3"))

hc3_df <- data.frame(
  term      = rownames(hc3),
  estimate  = hc3[, 1],
  std_error = hc3[, 2],
  statistic = hc3[, 3],
  p_value   = hc3[, 4],
  row.names = NULL,
  check.names = FALSE
)

write_csv(hc3_df, "results/tables/complete_case_hc3.csv")

# Quick diagnostic figure: residuals vs fitted (complete-case)
p <- ggplot(data.frame(fitted = fitted(m_cc), resid = resid(m_cc)), aes(x = fitted, y = resid)) +
  geom_point(alpha = 0.3) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(title = "Residuals vs Fitted (complete-case)", x = "Fitted", y = "Residuals") +
  theme_minimal(base_size = 14)

ggsave("results/figures/resid_vs_fitted.png", p, width = 7, height = 5, dpi = 200)
