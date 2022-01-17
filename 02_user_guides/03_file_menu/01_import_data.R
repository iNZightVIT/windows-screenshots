# load data
DIR <- file.path(DIR, "import_data")

w <- iNZight:::iNZImportWin$new(ui)
capture("01_import_file")

capture("02_import_browse")
crop("02_import_browse", y1 = 200)
add_rect("02_import_browse", 478, 190, 68, 34,
    border_width = 3L)

w$loadURL$set_value(TRUE)
capture("03_import_url")
crop("03_import_url", y1 = 200)

w$close()
