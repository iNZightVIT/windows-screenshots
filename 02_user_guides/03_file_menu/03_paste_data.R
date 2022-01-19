# load data
DIR <- file.path(DIR, "03_paste_data")

w <- iNZight:::iNZClipboard$new(ui, type = "paste")
capture("01_paste_from")

ui$close()
ui <- iNZight()
Sys.sleep(1)
