# load data
DIR <- file.path(DIR, "05_dataset_operations")

m <- gmessage("Click Dataset > Dataset operation")
Sys.sleep(5)

dataset_menu <- RGtk2::gtkContainerGetChildren(
    ui$menuBarWidget$menubar$widget
)[[2]]
RGtk2::gtkMenuItemSelect(dataset_menu)

Sys.sleep(2)
dataop_menu <- RGtk2::gtkContainerGetChildren(
    RGtk2::gtkMenuItemGetSubmenu(dataset_menu)
)[[5]]
RGtk2::gtkMenuItemSelect(dataop_menu)

capture("00_dataset_operations_menu")
RGtk2::gtkMenuItemDeselect(dataop_menu)
RGtk2::gtkMenuItemDeselect(dataset_menu)

crop("00_dataset_operations_menu", 32, 405, 135, y1 = 206)

w <- iNZight:::iNZReshapeWin$new(ui)
w$body$children[[2]]$set_index(2L)
capture("01_dataset_reshape_long2wide_win")

w$body$children[[2]]$set_index(3L)
capture("02_dataset_reshape_wide2long_win")
w$close()

w <- iNZight:::iNZSeparateWin$new(ui)
capture("03_dataset_separate_cols_win")

w$format$set_index(2L)
capture("03_dataset_separate_rows_win")
w$close()

w <- iNZight:::iNZUniteWin$new(ui)
capture("03_dataset_unite_win")
w$close()
