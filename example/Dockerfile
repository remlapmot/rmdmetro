FROM rmdmetro
RUN R -q -e "install.packages('reshape')"
WORKDIR /home/example
COPY example.Rmd bibliography.bib ./
CMD R -q -e "rmarkdown::render('example.Rmd', encoding = 'UTF-8')"
