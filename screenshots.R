# start R from: ~\iNZightVIT-dev\R\bin\Rscript.exe
options(repos = "https://cran.rstudio.com")
if (!requireNamespace("jsonlite")) install.packages("jsonlite")
if (!requireNamespace("rlang")) install.packages("rlang")

if (dir.exists(file.path("~", "iNZightVIT-dev", "library"))) {
    .libPaths(file.path("~", "iNZightVIT-dev", "library"))
} else {
    .libPaths(file.path("~", "iNZightVIT", "library"))
}

library(iNZight)
if (!requireNamespace("magick")) install.packages("magick")

if (!dir.exists("images")) dir.create("images")

DIR <- ""
source("fns.R")

# 0. load iNZight

ui <- iNZight()
if (ui$preferences$dev.features ||
    !all(ui$preferences$window.size == c(1040, 640))) {
    ui$preferences$dev.features <- FALSE
    ui$preferences$window.size <- c(1040, 640)
    ui$savePreferences()
    ui$reload()
}
capture("00_inzight_init")

# ----- landing page
sections <- list.files(pattern = "[0-9]{2}\\_.+")
for (section in sections) {
    DIR <- section
    source(file.path(DIR, "main.R"))
}

ui$close()
