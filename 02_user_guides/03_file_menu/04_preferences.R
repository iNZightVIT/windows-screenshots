# load data
DIR <- file.path(DIR, "preferences")

w <- iNZight:::iNZPrefsWin$new(ui)
capture("01_general")

w$sections$set_value(2L)
capture("02_appearance")

w$sections$set_value(3L)
w$sections$children[[3]]$children[[2]]$set_value(TRUE)
capture("03_dev_features")

dispose(ui$modWin)
