rmarkdown::draft("myslides.Rmd", template = "metropolis",
                 package = "binb", edit = FALSE)
setwd("myslides")       ## template creates a new subdir
rmarkdown::render("myslides.Rmd")
