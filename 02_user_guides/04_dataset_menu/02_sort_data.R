# load data
DIR <- file.path(DIR, "02_sort_data")

w <- iNZight:::iNZSortWin$new(ui)
capture("01_sort_win")

w$close()
