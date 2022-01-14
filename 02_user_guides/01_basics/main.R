files <- list.files(DIR, pattern = "[0-9]{2}\\_.+R", full.names = TRUE)

ODIR <- DIR
for (file in files) {
    DIR <- ODIR
    source(file)
}
