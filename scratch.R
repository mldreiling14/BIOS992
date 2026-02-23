data <- read_csv("analysis_dataset.csv", show_col_types = F)

data |> select(flu_vaccinations_raw_value,
               year)


data_2010 <- read_csv("source_data/analytic_data2010.csv")

data_2010 <- select(year, fl)

data_2010 |> names()


any(str_detect(colnames(data17), regex("flu", ignore_case = T)))
