# rmdmetro
A Docker container for compiling Metropolis Beamer presentations in R Markdown.

The container installs the Fira Code, Fira Sans, Fira Mono, and Fira Math fonts.

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
