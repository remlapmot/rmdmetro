FROM rmdmetropolis
RUN mkdir /home/example
COPY example.Rmd /home/example/example.Rmd
COPY bibliography.bib /home/example/bibliography.bib 
CMD cd /home/example \ 
    && R -e "rmarkdown::render('example.Rmd', encoding = 'UTF-8')"
