# load data
DIR <- file.path(DIR, "import_data")

w <- iNZight:::iNZImportWin$new(ui)
capture("01_import_file")

w$loadURL$set_value(TRUE)
capture("01_import_url")

w$close()
