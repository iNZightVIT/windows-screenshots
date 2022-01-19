# load data
DIR <- file.path(DIR, "01_filter_dataset")

w <- iNZight:::iNZFilterWin$new(ui)
capture("01_filter_win")

w$filter_var$set_value("travel")
capture("02_filter_cat")

w$filter_var$set_value("height")
capture("03_filter_num")

w$filter_type$set_index(2L)
capture("04_filter_rows")

w$filter_type$set_index(3L)
capture("05_filter_random")

w$close()
