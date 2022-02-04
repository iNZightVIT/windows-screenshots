files <- list.files(DIR, pattern = "[0-9]{2}\\_.+R", full.names = TRUE)

ui$close()
ui <- iNZight(census.at.school.500)
Sys.sleep(1)

dataset_menu <- RGtk2::gtkContainerGetChildren(
    ui$menuBarWidget$menubar$widget
)[[2]]

RGtk2::gtkMenuItemSelect(dataset_menu)
capture("00_dataset_menu")
RGtk2::gtkMenuItemDeselect(dataset_menu)

# crop image
crop("00_dataset_menu", 3, 253, y1 = 382)

OODIR <- DIR
for (file in files) {
    DIR <- OODIR
    source(file)
}
