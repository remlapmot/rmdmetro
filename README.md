# rmdmetro
A Docker container for compiling Metropolis Beamer presentations in R Markdown.

The container installs the Fira Code, Fira Sans, Fira Mono, and Fira Math fonts.

Create a Dockerfile based on this image such as the following, copying in the files needed for your R Markdown Metropolis Beamer presentation.
```dockerfile
FROM rmdmetro
RUN R -q -e "install.packages('reshape')"
WORKDIR /home/example
COPY example.Rmd bibliography.bib ./
CMD R -q -e "rmarkdown::render('example.Rmd', encoding = 'UTF-8')"
```

Then copy the compiled pdf from the container, with a `docker cp` command such as
```bash
docker cp $(docker ps -alq):/home/example/example.pdf ./example/example.pdf
```

* Compile the container with
```bash
docker build -t rmdmetro .
```
or 
```bash
./dockerbuild
```

* Compile the examples with
```bash
./dockerbuild1
./dockerbuild2
./dockerbuild3
```

* The commands in `dockerint` launch the container interactively at its bash shell
```bash
./dockerint
```

* The container is on Docker Hub [here](https://hub.docker.com/r/remlapmot/rmdmetro)
