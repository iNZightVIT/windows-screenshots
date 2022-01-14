# 02 - subset_colour_size GIF
DIR <- file.path(DIR, "subset_colour_size")

ui$new_document(gapminder, name = "Gapminder")
Sys.sleep(1)

ui$ctrlWidget$V1box$set_value("Infantmortality")
ui$ctrlWidget$V2box$set_value("ChildrenPerWoman")
Sys.sleep(0.1)
capture("01")

ui$ctrlWidget$G1box$set_value("Year_cat")
Sys.sleep(0.1)
capture("02")

ui$getActiveDoc()$setSettings(
    list(
        colby = as.name("Region"),
        sizeby = as.name("Populationtotal"),
        alpha = 0.5,
        cex = 0.8
    )
)
YEARS <- levels(gapminder$Year_cat)
for (i in seq_along(YEARS)) {
    ui$ctrlWidget$ctrlGp$children[[1]]$children[[14]]$set_value(YEARS[i])
    capture(sprintf("%02d", 2L + i))
}

files <- list.files(file.path("images", "landing"),
    pattern = "subset_colour_size_.+png",
    full.names = TRUE
)
dir_to_gif(delay = c(200, 200, rep(50, length(YEARS))))
