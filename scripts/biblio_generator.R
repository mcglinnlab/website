#devtools::install_github("petzi53/bib2academic", build_vignettes = TRUE)

library(bib2academic)

bib2acad("mcglinnlab_pubs.bib", copybib = TRUE, abstract = TRUE,
         overwrite = TRUE)

mdfiles = dir('my-md-folder')

for(i in seq_along(mdfiles)) {
    my_pub = readLines(file.path('my-md-folder', mdfiles[i]))
    if (my_pub[4] == "publication_types = [\"2\"]") {
        pdata = unlist(strsplit(my_pub[6], ', '))
        title = pdata[1]
        title = sub("In: ", "_", title)
        title = paste0(title, '_')
        vol = pdata[2]
        vol = sub("(", "", vol, fixed = TRUE)
        vol = sub(")", "", vol, fixed = TRUE)
        vol = paste0("*", vol, ":*")
        pages = pdata[grep('_pp.', pdata)]
        pages = gsub("_", "", pages)
        pages = sub("pp. ", "", pages)
        pages = sub('\"', '', pages)
        urls = pdata[grep('http', pdata)]
        urls = sub('\"', '', urls, fixed = TRUE)
        publication = paste0(title, ", ", vol, pages, "\"")
        my_pub[6] = publication
        my_pub = my_pub[-grep("url_", my_pub)[-1]]
        my_pub[grep("url_", my_pub)] = paste0('url_custom = [{name = "HTML", url = "',
                                              urls[1], '"}]')
    }
    ## fix Di Franco name issue
    #if (mdfiles[i] == "2019-01-01_blowes_mediterranean_2019.md") {
    #    my_pub[5] = sub("{", "", my_pub[5], fixed = TRUE)
    #    my_pub[5] = sub("}", "", my_pub[5], fixed = TRUE)
    #}    
    write(my_pub, file = file.path('my-md-folder', mdfiles[i]))
}


blogdown:::serve_site()
