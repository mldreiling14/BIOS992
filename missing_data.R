library(tidyverse)

data <- read_csv("analysis_dataset.csv", show_col_types = F)

names(data)

data1 <- data |> select(
  -contains("ci"),
  -contains("numer"),
  -contains("denom")
  )
names(data1)

missing_data <- tibble(
  column = names(data1),
  n_missing = colSums(is.na(data1)),
  percent_missing = colMeans(is.na(data1)) * 100
) |>
  arrange(desc(percent_missing))


count(missing_data |> filter(percent_missing <= 90))

count(missing_data |> filter(percent_missing <= 75))

count(missing_data |> filter(percent_missing <= 50))

missing_profile <- missing_data |> mutate(
  missing_band = cut(
    percent_missing,
    breaks = c(-Inf, 5, 25, 50, 75, 90, Inf),
    labels = c("<5%", "5-25%", "25-50%", "50-75%", "75-90%", ">90%"), 
    right = F
  )
) |> count(missing_band, name = "n_columns") |>
  mutate(
    pct_columns = round(n_columns / sum(n_columns) * 100, 1)
  )
missing_profile

missing_summary <- missing_data |>
  summarise(
    n_columns = n(),
    mean_missing = round(mean(percent_missing), 1),
    median_missing = round(median(percent_missing), 1),
    max_missing = round(max(percent_missing), 1),
    n_gt_20 = sum(percent_missing > 20),
    n_gt_50 = sum(percent_missing > 50)
  )

missing_summary




per_missing <- function(colname){
  col <- data1[[colname]]
  missing <- sum(is.na(col))
  total <- length(col)
  missing / total * 100
}






