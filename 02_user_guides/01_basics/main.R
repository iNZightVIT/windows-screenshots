files <- list.files(DIR, pattern = "[0-9]{2}\\_.+R", full.names = TRUE)

OODIR <- DIR
for (file in files) {
    DIR <- OODIR
    source(file)
}
