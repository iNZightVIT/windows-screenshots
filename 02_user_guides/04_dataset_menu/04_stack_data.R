# load data
DIR <- file.path(DIR, "04_stack_data")

w <- iNZight:::iNZStackWin$new(ui)
capture("01_stack_win")

w$close()
