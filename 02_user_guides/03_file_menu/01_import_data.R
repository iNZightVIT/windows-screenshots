# load data
DIR <- file.path(DIR, "01_import_data")

w <- iNZight:::iNZImportWin$new(ui)
capture("01_import_file")

capture("02_import_browse")
crop("02_import_browse", y1 = 200)
# add_rect("02_import_browse", 478, 102, 664, 70,
#     border_width = 3L)
add_arrow("02_import_browse", 400, 86, 520,
    arrow_width = 5L,
    head_length = 0.3
)

w$loadURL$set_value(TRUE)
capture("03_import_url")
crop("03_import_url", y1 = 200)

add_arrow("03_import_url", 45, 115, 83,
    arrow_width = 5L,
    head_length = 0.3
)
add_circle("03_import_url", 25, 115, 5, width = 5L)
add_text("03_import_url", 25, 115, "1", font_size = 1.8)

add_arrow("03_import_url", 300, 82, 220,
    arrow_width = 5L,
    head_length = 0.3
)
add_circle("03_import_url", 320, 82, 5, width = 5L)
add_text("03_import_url", 320, 82, "2", font_size = 1.8)
add_text("03_import_url", 340, 82, 
    "Type/paste in URL", font_size = 1.2,
    justify_x = 0)


w$close()
