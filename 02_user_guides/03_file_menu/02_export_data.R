# load data
DIR <- file.path(DIR, "02_export_data")

ui$new_document(census.at.school.500, name = "Census at School 500")
Sys.sleep(1)

w <- iNZight:::iNZExportWin$new(ui)
capture("01_export_win")
add_rect("01_export_win", 511, 45, 671, 70,
    border_width = 3L
)

svalue(w$file) <- "path/to/export.csv"
capture("02_export_path_set")
add_arrow("02_export_path_set", 540, 92, 420,
    arrow_width = 5L,
    head_length = 0.3
)
add_rect("02_export_path_set", 428, 191, 544, 220,
    border_width = 3L
)

w$close()
