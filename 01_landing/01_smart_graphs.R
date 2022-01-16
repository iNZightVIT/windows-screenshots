# 01 - smart_graphs GIF

DIR <- file.path(DIR, "smart_graphs")

ui$new_document(census.at.school.500, name = "Census at School 500")
Sys.sleep(1)
ui$ctrlWidget$V1box$set_value("height")
capture("01")

ui$ctrlWidget$V2box$set_value("gender")
capture("02")

ui$ctrlWidget$V2box$set_value("armspan")
capture("03")

ui$ctrlWidget$V2box$set_index(1)
Sys.sleep(0.1)
ui$ctrlWidget$V1box$set_value("travel")
capture("04")

ui$ctrlWidget$V2box$set_value("gender")
capture("05")

dir_to_gif(delay = 200)
