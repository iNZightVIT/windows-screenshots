# start R from: ~\iNZightVIT-dev\R\bin\Rscript.exe

# install.packages(c('jsonlite', 'rlang'))

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

    Sys.sleep(0.5)
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

crop <- function(file,
                 x0 = 0, x1 = img_info$width[1],
                 y0 = 0, y1 = img_info$height[1]
                 ) {
    if (missing(file)) stop("You need to specify a path")
    dir <- "images"
    if (DIR != "") dir <- file.path(dir, DIR)
    name <- sprintf(
        "%s.png",
        file.path(dir, file)
    )
    message('Editing ', name, ' ...')
    if (!file.exists(name)) stop("File does not exist")

    img <- magick::image_read(name)
    img_info <- magick::image_info(img)

    img_cropped <- magick::image_crop(
        img,
        magick::geometry_area(x1 - x0, y1 - y0, x0, y0)
    )

    magick::image_write(img_cropped, name)
    invisible(NULL)
}

add_rect <- function(file, x0, width, y0, height,
                     border_col = "red", border_width = 2,
                     fill_col = NA) {
    if (missing(file)) stop("You need to specify a path")
    dir <- "images"
    if (DIR != "") dir <- file.path(dir, DIR)
    name <- sprintf(
        "%s.png",
        file.path(dir, file)
    )
    message('Editing ', name, ' ...')
    if (!file.exists(name)) stop("File does not exist")

    img <- magick::image_read(name)

    img_e <- magick::image_draw(img)
    rect(x0, y0, x0 + width, y0 + height,
        border = border_col, lwd = border_width,
        bg = fill_col
    )
    dev.off()
    magick::image_write(img_e, name)
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
for (section in sections[2]) {
    DIR <- section
    source(file.path(DIR, "main.R"))
}

ui$close()
