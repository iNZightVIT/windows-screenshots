# load data
DIR <- file.path(DIR, "export_data")

ui$new_document(census.at.school.500, name = "Census at School 500")
Sys.sleep(1)

w <- iNZight:::iNZExportWin$new(ui)
capture("01_export_win")

svalue(w$file) <- "path/to/export.csv"
capture("02_export_path_set")

w$close()
