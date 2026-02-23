library('tidyverse')

flu <- readxl::read_xlsx("source_data/Influenza_Laboratory-Confirmed_Cases_by_County__Beginning_2009-10_Season_20260107.xlsx")

read_chr_year <- function(year) {
  filepath <- paste0("source_data/analytic_data", year, ".csv")
  
  read_csv(filepath, show_col_types = FALSE) |>
    mutate(year = year)
}

years <- 2010:2025

chr_all <- map_dfr(years, read_chr_year)

chr_all <- chr_all |> janitor::clean_names()

ny <- chr_all |> filter(state_abbreviation == "NY") 

ny

ny_clean <- ny |>
  mutate(
    fips = str_pad(as.character(x5_digit_fips_code), 5, pad = "0")
  )

flu_clean <- flu |>
  janitor::clean_names() |>
  mutate(
    fips = str_pad(as.character(fips), 5, pad = "0"),
    year = as.integer(str_sub(season, 1, 4))
  ) |>
  group_by(fips, year) |>
  summarise(
    total_cases = sum(count, na.rm = TRUE),
    .groups = "drop"
  )

analysis_df <- flu_clean |>
  inner_join(ny_clean, by = c("fips", "year"))

analysis_df

readr::write_csv(analysis_df, "analysis_dataset.csv")
