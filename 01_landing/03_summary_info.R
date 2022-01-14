# 03 - summary_info GIF
DIR <- file.path(DIR, "summary_info")

data("nhanes2009_2012", package = "FutureLearnData")
nhanes2009_2012$Education.reord <- nhanes2009_2012$Education
levels(nhanes2009_2012$Education.reord) <- 
    levels(nhanes2009_2012$Education.reord)[c(1, 2, 4, 5, 3)]
ui$new_document(nhanes2009_2012, name = "NHANES Dataset (2009 - 2012)")
Sys.sleep(1)

ui$ctrlWidget$V1box$set_value("Education.reord")
ui$ctrlWidget$V2box$set_value("Gender")
capture("01")

s <- iNZight:::iNZGetSummary(ui)
# set iNZight window as active
focus(ui$win) <- TRUE
RGtk2::gtkWindowResize(s$win$widget, 900, 520)
Sys.sleep(1)
capture("02")
gWidgets2::dispose(s$win)

ui$ctrlWidget$V1box$set_value("Height")
ui$ctrlWidget$V2box$set_value("Gender")
capture("03")

s <- iNZight:::iNZGetSummary(ui)
# set iNZight window as active
focus(ui$win) <- TRUE
RGtk2::gtkWindowResize(s$win$widget, 900, 520)
Sys.sleep(1)
capture("04")
gWidgets2::dispose(s$win)

ui$ctrlWidget$V1box$set_value("BPSys1")
ui$ctrlWidget$V2box$set_value("BPSys3")
ui$getActiveDoc()$setSettings(
    list(
        trend = "linear",
        LOE = TRUE
    )
)
capture("05")

s <- iNZight:::iNZGetSummary(ui)
# set iNZight window as active
focus(ui$win) <- TRUE
RGtk2::gtkWindowResize(s$win$widget, 900, 520)
Sys.sleep(1)
capture("06")
gWidgets2::dispose(s$win)

dir_to_gif(delay = c(1, 2, 1, 2, 1, 2) * 100)
