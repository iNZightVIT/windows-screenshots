# load data
DIR <- file.path(DIR, "load_data")

ui$close()
ui <- iNZight()
Sys.sleep(1)

w <- iNZight:::iNZImportWin$new(ui)
capture("01_import_window")

w$close()

w <- iNZight:::iNZImportExampleWin$new(ui)
w$dsData$set_value("census.at.school.500")
capture("02_import_example")

w$close()
