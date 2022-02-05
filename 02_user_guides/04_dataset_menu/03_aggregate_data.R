# load data
DIR <- file.path(DIR, "03_aggregate_data")

w <- iNZight:::iNZAggregateWin$new(ui)
capture("01_aggregate_win")

w$close()
