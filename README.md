# rmdmetro
A Docker container for compiling Metropolis Beamer presentations in R Markdown.

The container installs the Fira Code, Fira Sans, Fira Mono, and Fira Math fonts.

Create a Dockerfile based on this image such as the following, copying in the files needed for your R Markdown Metropolis Beamer presentation.
```dockerfile
FROM remlapmot/rmdmetro
RUN mkdir /home/example
COPY example.Rmd /home/example/example.Rmd
COPY bibliography.bib /home/example/bibliography.bib 
CMD cd /home/example \ 
    && R -e "rmarkdown::render('example.Rmd', encoding = 'UTF-8')"
```

Then copy the compiled pdf from the container, with a docker cp command such as
```
docker cp $(docker ps -alq):/home/example/example.pdf ./example/example.pdf
```

* Compile the container with
```
docker build -t rmdmetro .
```
or 
```
./dockerbuild
```

* Compile the examples with
```
./dockerbuild1
./dockerbuild2
./dockerbuild3
```

* The commands in `dockerint` launch the container at its bash shell
```
./dockerint
```

* The container is on Docker Hub [here](https://hub.docker.com/r/remlapmot/rmdmetro)