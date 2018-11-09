#devtools::install_github("petzi53/bib2academic", build_vignettes = TRUE)

library(bib2academic)

bib2acad("mcglinnlab_pubs.bib", copybib = TRUE, abstract = TRUE,
         overwrite = TRUE)

blogdown:::serve_site()
