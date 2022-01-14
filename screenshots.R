# start R from: ~\iNZightVIT-dev\R\bin\Rscript.exe

if (dir.exists(file.path("~", "iNZightVIT-dev", "library"))) {
    .libPaths(file.path("~", "iNZightVIT-dev", "library"))
} else {
    .libPaths(file.path("~", "iNZightVIT", "library"))
}

library(iNZight)
# install.packages("magick")

if (!dir.exists("images")) dir.create("images")

capture <- function(...) {
    path <- list(...)
    if (length(path) == 0) stop("You need to specify a path")
    name <- sprintf(
        "%s.png",
        file.path("images", do.call(file.path, path))
    )
    dir <- dirname(name)
    if (!dir.exists(dir)) dir.create(dir, recursive = TRUE)

    s <- system(sprintf("nircmd.exe savescreenshotwin %s", name))
    invisible(s)
}

dir_to_gif <- function(files, gif, ...) {
    img_list <- lapply(files, magick::image_read)
    img_joined <- magick::image_join(img_list)
    img_animated <- magick::image_animate(img_joined, ...)
    magick::image_write(
        image = img_animated,
        path = file.path("images", sprintf("%s.gif", gif))
    )
}

# 0. load iNZight

ui <- iNZight()
ui$preferences$dev.features <- FALSE
ui$preferences$window.size <- c(1040, 640)
ui$savePreferences()
ui$reload()
capture("00_inzight_init")

# ----- landing page

# 01 - smart_graphs GIF
ui$new_document(census.at.school.500, name = "Census at School 500")
Sys.sleep(1)
ui$ctrlWidget$V1box$set_value("height")
Sys.sleep(1)
capture("landing", "smart_graphs_01")

ui$ctrlWidget$V2box$set_value("gender")
Sys.sleep(0.1)
capture("landing", "smart_graphs_02")

ui$ctrlWidget$V2box$set_value("armspan")
Sys.sleep(0.1)
capture("landing", "smart_graphs_03")

ui$ctrlWidget$V2box$set_index(1)
Sys.sleep(0.1)
ui$ctrlWidget$V1box$set_value("travel")
Sys.sleep(0.1)
capture("landing", "smart_graphs_04")

ui$ctrlWidget$V2box$set_value("gender")
Sys.sleep(0.1)
capture("landing", "smart_graphs_05")

files <- list.files(file.path("images", "landing"),
    pattern = "smart_graphs_.+png",
    full.names = TRUE
)
dir_to_gif(files, "landing/01_smart_graphs", delay = 200)
unlink(files)

# 02 - subset_colour_size GIF
ui$new_document(gapminder, name = "Gapminder")
Sys.sleep(1)

ui$ctrlWidget$V1box$set_value("Infantmortality")
ui$ctrlWidget$V2box$set_value("ChildrenPerWoman")
Sys.sleep(0.1)
capture("landing", "subset_colour_size_01")

ui$ctrlWidget$G1box$set_value("Year_cat")
Sys.sleep(0.1)
capture("landing", "subset_colour_size_02")

ui$ctrlWidget$ctrlGp$children[[1]]$children[[14]]$set_value("[1964]")
ui$getActiveDoc()$setSettings(
    list(
        colby = as.name("Region"),
        sizeby = as.name("Populationtotal"),
        alpha = 0.5,
        cex = 0.8
    )
)
capture("landing", "subset_colour_size_03")

files <- list.files(file.path("images", "landing"),
    pattern = "subset_colour_size_.+png",
    full.names = TRUE
)
dir_to_gif(files, "landing/02_subset_colour_size", delay = 200)
unlink(files)

# 03 - summary_info GIF
data("nhanes2009_2012", package = "FutureLearnData")
nhanes2009_2012$Education.reord <- nhanes2009_2012$Education
levels(nhanes2009_2012$Education.reord) <- 
    levels(nhanes2009_2012$Education.reord)[c(1, 2, 4, 5, 3)]
ui$new_document(nhanes2009_2012, name = "NHANES Dataset (2009 - 2012)")
Sys.sleep(1)

ui$ctrlWidget$V1box$set_value("Education.reord")
ui$ctrlWidget$V2box$set_value("Gender")
capture("landing", "summary_info_01")

s <- iNZight:::iNZGetSummary(ui)
# set iNZight window as active
focus(ui$win) <- TRUE
RGtk2::gtkWindowResize(s$win$widget, 900, 520)
Sys.sleep(1)
capture("landing", "summary_info_02")
gWidgets2::dispose(s$win)

ui$ctrlWidget$V1box$set_value("Height")
ui$ctrlWidget$V2box$set_value("Gender")
capture("landing", "summary_info_03")

s <- iNZight:::iNZGetSummary(ui)
# set iNZight window as active
focus(ui$win) <- TRUE
RGtk2::gtkWindowResize(s$win$widget, 900, 520)
Sys.sleep(1)
capture("landing", "summary_info_04")
gWidgets2::dispose(s$win)

ui$ctrlWidget$V1box$set_value("BPSys1")
ui$ctrlWidget$V2box$set_value("BPSys3")
ui$getActiveDoc()$setSettings(
    list(
        trend = "linear",
        LOE = TRUE
    )
)
capture("landing", "summary_info_05")

s <- iNZight:::iNZGetSummary(ui)
# set iNZight window as active
focus(ui$win) <- TRUE
RGtk2::gtkWindowResize(s$win$widget, 900, 520)
Sys.sleep(1)
capture("landing", "summary_info_06")
gWidgets2::dispose(s$win)

files <- list.files(file.path("images", "landing"),
    pattern = "summary_info_.+png",
    full.names = TRUE
)
dir_to_gif(files, "landing/03_summary_info", delay = c(1, 2, 1, 2, 1, 2) * 100)
unlink(files)



ui$close()
