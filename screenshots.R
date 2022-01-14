# start R from: ~\iNZightVIT-dev\R\bin\Rscript.exe

if (dir.exists(file.path("~", "iNZightVIT-dev", "library"))) {
    .libPaths(file.path("~", "iNZightVIT-dev", "library"))
} else {
    .libPaths(file.path("~", "iNZightVIT", "library"))
}

library(iNZight)
# install.packages("magick")

if (!dir.exists("images")) dir.create("images")

DIR <- ""
capture <- function(file) {
    if (missing(file)) stop("You need to specify a path")
    dir <- "images"
    if (DIR != "") dir <- file.path(dir, DIR)
    name <- sprintf(
        "%s.png",
        file.path(dir, file)
    )
    if (!dir.exists(dir)) dir.create(dir, recursive = TRUE)

    s <- system(sprintf("nircmd.exe savescreenshotwin %s", name))
    invisible(s)
}

dir_to_gif <- function(...) {
    dir <- "images"
    if (DIR != "") dir <- file.path(dir, DIR)

    files <- list.files(dir,
        pattern = "\\.png",
        full.names = TRUE
    )
    img_list <- lapply(files, magick::image_read)
    img_joined <- magick::image_join(img_list)
    img_animated <- magick::image_animate(img_joined, ...)
    magick::image_write(
        image = img_animated,
        path = sprintf("%s.gif", dir)
    )
    unlink(dir, recursive = TRUE)
}

# 0. load iNZight

ui <- iNZight()
ui$preferences$dev.features <- FALSE
ui$preferences$window.size <- c(1040, 640)
ui$savePreferences()
ui$reload()
capture("00_inzight_init")

# ----- landing page
sections <- list.files(pattern = "[0-9]{2}\\_.+")
for (section in sections) {
    DIR <- section
    source(file.path(DIR, "main.R"))
}

ui$close()
