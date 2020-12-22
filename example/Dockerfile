FROM rmdmetropolis
RUN mkdir /home/example
COPY example.Rmd /home/example/example.Rmd
COPY bibliography.bib /home/example/bibliography.bib 
COPY img /home/example/img
CMD cd /home/example \ 
    && R -e "rmarkdown::render('example.Rmd', encoding = 'UTF-8')"
