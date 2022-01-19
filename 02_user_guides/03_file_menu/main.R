files <- list.files(DIR, pattern = "[0-9]{2}\\_.+R", full.names = TRUE)

ui$close()
ui <- iNZight()
Sys.sleep(1)

file_menu <- RGtk2::gtkContainerGetChildren(
    ui$menuBarWidget$menubar$widget
)[[1]]

RGtk2::gtkMenuItemSelect(file_menu)
capture("00_file_menu")
RGtk2::gtkMenuItemDeselect(file_menu)

# crop image
crop("00_file_menu", 10, 410, y1 = 250)

OODIR <- DIR
for (file in files[2]) {
    DIR <- OODIR
    source(file)
}
