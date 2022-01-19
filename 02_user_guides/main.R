dirs <- list.files(DIR, pattern = "[0-9]{2}\\_")

ODIR <- DIR
for (dir in dirs) {
    DIR <- file.path(ODIR, dir)
    source(file.path(DIR, "main.R"))
}
