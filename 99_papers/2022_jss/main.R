window_dims <- c(1315, 840)

if (!ui$preferences$dev.features ||
    !all(ui$preferences$window.size == window_dims)) {
    ui$preferences$dev.features <- TRUE
    ui$preferences$code.panel <- TRUE
    ui$preferences$window.size <- window_dims
    ui$savePreferences()
}

ui$close()
ui <- iNZight()

## -- Figure 1: iNZight GUI landing page

capture("01_inzight_main")

add_circle("01_inzight_main", 360, 120, 10, col = "gray20", fill_col = "gray")
add_text("01_inzight_main", 360, 120, "A", font_col = "black", font_size = 3)

add_circle("01_inzight_main", 300, 640, 10, col = "gray20", fill_col = "gray")
add_text("01_inzight_main", 300, 640, "B", font_col = "black", font_size = 3)

add_circle("01_inzight_main", 520, 140, 10, col = "gray20", fill_col = "gray")
add_text("01_inzight_main", 520, 140, "C", font_col = "black", font_size = 3)

add_circle("01_inzight_main", 820, 745, 10, col = "gray20", fill_col = "gray")
add_text("01_inzight_main", 820, 745, "D", font_col = "black", font_size = 3)

add_circle("01_inzight_main", 140, 805, 10, col = "gray20", fill_col = "gray")
add_text("01_inzight_main", 140, 805, "E", font_col = "black", font_size = 3)


## -- Figure 2: Load Data window

if (!file.exists("Gapminder.csv"))
    download.file(
        "https://www.stat.auckland.ac.nz/~wild/data/FutureLearn/Gapminder.csv",
        "Gapminder.csv"
    )
w <- iNZight:::iNZImportWin(ui)
w$fname <- "Gapminder.csv"
w$setfile()
Sys.sleep(1)
visible(w$advGp) <- TRUE

capture("02_import_data")

w$import()

## -- Figure 3: Plot modifications example

# - filter out levels of Year_cat
f <- iNZight:::iNZFilterWin(ui)
f$filter_var$set_value("Year_cat")
f$cat_levels$set_value(levels(ui$getActiveData()$Year_cat)[3:15])
f$cat_levels$invoke_change_handler()
f$ok_button$invoke_change_handler()

ui$ctrlWidget$V1box$set_value("Infantmortality")
ui$ctrlWidget$V2box$set_value("GDPpercapita")
ui$ctrlWidget$G1box$set_value("Year_cat")
ui$getActiveDoc()$setSettings(
    list(
        transform = list(x = "log10"),
        colby = as.name("Region"),
        sizeby = as.name("Populationtotal"),
        cex = 0.7,
        alpha = 0.4,
        col.fun = "contrast",
        main = "Infant mortality by GDP over time",
        xlab = "GDP per capita (log scale)",
        ylab = "Infant mortality"
    )
)
ui$code_panel$store_code()

capture("03_plot_modifications")

add_rect(
    "03_plot_modifications",
    148, 30, 185, 52,
    border_col = "blue", border_width = 5L
)
add_rect(
    "03_plot_modifications",
    1115, 720, 1170, 770,
    border_col = "red", border_width = 5L
)

## -- Figure 4: Get Inference

ui$getActiveDoc()$setSettings(
    list(colby = NULL, sizeby = NULL, transform = NULL)
)
ui$ctrlWidget$V2box$set_value("Region")
ui$ctrlWidget$ctrlGp$children[[1]]$children[[14]]$set_value("[2004]")

w <- iNZight:::iNZGetInference(ui)
w$hypothesis_test$set_index(2)
size(w$win) <- c(850, 790)

capture("04_get_inference")

## TODO: save inference to history

dispose(w$win)

## --- Figure 5: Spearate columns

## TODO: FIX THIS ONE TOO
w <- iNZight:::iNZSeparateWin(ui)
w$var1$set_value("Region.Geo")
w$var2$set_value(" - ")
w$leftCol$set_value("main_region")
w$rightCol$set_value("part_region")
w$var1$invoke_change_handler()
w$var2$invoke_change_handler()

stop("YOU NEED TO FIX THIS")

capture("05_separate_cols")

w$ok_button$invoke_change_handler()

add_rect(
    "05_separate_cols",
    130, 210, 235, 460,
    border_col = "red", border_width = 4L
)
add_rect(
    "05_separate_cols",
    470, 210, 610, 460,
    border_col = "red", border_width = 4L
)


## --- Figure 6: Survey design

e <- iNZight:::iNZImportExampleWin$new(ui)
e$dsPkg$set_value("Survey")
e$dsData$set_value("apiclus1")
e$ok_button$invoke_change_handler()

w <- iNZight:::iNZSurveyDesign$new(ui)
w$clus1Var$set_value("dnum")
w$wtVar$set_value("pw")
w$fpcVar$set_value("fpc")

capture("06_survey_design")

w$ok_button$invoke_change_handler()


## --- Figure 7: Survey summary

ui$ctrlWidget$V1box$set_value("stype")
w <- iNZight:::iNZGetSummary(ui)

## TODO: save summary to history

capture("07_survey_summary")

dispose(w$win)


## --- Figure 8: Time series

e <- iNZight:::iNZImportExampleWin$new(ui)
e$dsPkg$set_value("Time Series")
e$dsData$set_value("visitorsQ")
e$ok_button$invoke_change_handler()

tsMod <- iNZightModules:::iNZightTSMod$new(ui)

capture("08_time_series")

tsMod$close()

## --- Figure 9: Maps (not yet automated)

# if (!requireNamespace("iNZightMaps"))
#     install.packages("iNZightMaps",
#         repos = c(
#             options()$repos,
#             "https://r.docker.stat.auckland.ac.nz"
#         )
#     )

# e <- iNZight:::iNZImportExampleWin$new(ui)
# e$dsPkg$set_value("Maps")
# e$dsData$set_value("nzquakes")
# e$ok_button$invoke_change_handler()

# mapMod <- iNZightModules:::iNZightMap2Mod$new(ui)


## -- grab script ...

writeLines(ui$rhistory$get(), file.path("images", DIR, "session_script.R"))


## --- Figure 10: Class reference

ui$close()
ui <- iNZight()

capture("10_inzight_classes")

r <- c(5, 33, 1310, 53)
add_rect(
    "10_inzight_classes",
    r[1], r[2], r[3], r[4],
    border_col = NA,
    fill_col = "#999999ee"
)
add_text("10_inzight_classes",
    (r[3]-r[1])/2+r[1], (r[4]-r[2])/2+r[2],
    "iNZMenuBarWidget",
    font_col = "black", font_size = 1.2)

r <- c(5, 55, 423, 85)
add_rect(
    "10_inzight_classes",
    r[1], r[2], r[3], r[4],
    border_col = NA,
    fill_col = "#999999ee"
)
add_text("10_inzight_classes",
    (r[3]-r[1])/2+r[1], (r[4]-r[2])/2+r[2],
    "iNZDataNameWidget",
    font_col = "black", font_size = 1.2)

r <- c(5, 87, 423, 123)
add_rect(
    "10_inzight_classes",
    r[1], r[2], r[3], r[4],
    border_col = NA,
    fill_col = "#999999ee"
)
add_text("10_inzight_classes",
    (r[3]-r[1])/2+r[1], (r[4]-r[2])/2+r[2],
    "iNZDataToolbar",
    font_col = "black", font_size = 1.2)

r <- c(5, 125, 423, 600)
add_rect(
    "10_inzight_classes",
    r[1], r[2], r[3], r[4],
    border_col = NA,
    fill_col = "#999999ee"
)
add_text("10_inzight_classes",
    (r[3]-r[1])/2+r[1], (r[4]-r[2])/2+r[2],
    "iNZDataViewWidget",
    font_col = "black", font_size = 1.2)

r <- c(5, 602, 423, 770)
add_rect(
    "10_inzight_classes",
    r[1], r[2], r[3], r[4],
    border_col = NA,
    fill_col = "#999999ee"
)
add_text("10_inzight_classes",
    (r[3]-r[1])/2+r[1], (r[4]-r[2])/2+r[2],
    "iNZControlWidget",
    font_col = "black", font_size = 1.2)

r <- c(425, 55, 1310, 720)
add_rect(
    "10_inzight_classes",
    r[1], r[2], r[3], r[4],
    border_col = NA,
    fill_col = "#999999ee"
)
add_text("10_inzight_classes",
    (r[3]-r[1])/2+r[1], (r[4]-r[2])/2+r[2],
    "iNZPlotWidget",
    font_col = "black", font_size = 1.2)

r <- c(425, 722, 1310, 770)
add_rect(
    "10_inzight_classes",
    r[1], r[2], r[3], r[4],
    border_col = NA,
    fill_col = "#999999ee"
)
add_text("10_inzight_classes",
    (r[3]-r[1])/2+r[1], (r[4]-r[2])/2+r[2],
    "iNZPlotToolbar",
    font_col = "black", font_size = 1.2)

r <- c(5, 772, 1310, 865)
add_rect(
    "10_inzight_classes",
    r[1], r[2], r[3], r[4],
    border_col = NA,
    fill_col = "#999999ee"
)
add_text("10_inzight_classes",
    (r[3]-r[1])/2+r[1], (r[4]-r[2])/2+r[2],
    "iNZCodePanel",
    font_col = "black", font_size = 1.2)
