ARG R=latest
FROM rocker/verse:${R}
LABEL maintainer="Tom Palmer <remlapmot@hotmail.com>" \
      org.opencontainers.image.authors="Tom Palmer" \
      author.orcid="0000-0003-4655-4511" \
      org.opencontainers.image.url="https://hub.docker.com/repository/docker/remlapmot/rmdmetro" \
      org.label-schema.vcs-url="https://github.com/remlapmot/rmdmetro" \
      org.label-schema.license="GPL-2.0"

# RUN rm /usr/lib/rstudio-server/bin/quarto/bin/pandoc && \
#     ln -s /usr/local/bin/pandoc /usr/lib/rstudio-server/bin/quarto/bin/pandoc; \

# install Fira Code, Fira Sans, and Fira Mono; and libpoppler-cpp-dev (for pdftools R package)
# add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse" && \
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends fonts-firacode \
                                               libpoppler-cpp-dev \
                                               software-properties-common \
                                               texlive-fonts-extra && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/*
    
# R code
# update texlive manager
# alternative code to install Fira Sans and Fira Mono
# install Fira Math
# install additional texlive packages
RUN R -e "install.packages(c('binb', 'pdftools')); \
          tinytex::tlmgr_install(c( \
                                   'fira', \
                                   'firamath', \
                                   'beamer', \
                                   'beamertheme-metropolis', \
                                   'infwarerr', \
                                   'kvoptions', \
                                   'euenc', \
                                   'fontspec', \
                                   'unicode-math', \
                                   'xunicode', \
                                   'pgfopts', \
                                   'appendixnumberbeamer', \
                                   'biblatex-chicago', \
                                   'xstring', \
                                   'logreq', \
                                   'biblatex', \
                                   'biber', \
                                   'fancyvrb', \
                                   'framed', \
                                   'booktabs', \
                                   'caption', \
                                   'grffile', \
                                   'mathspec', \
                                   'preview', \
                                   'epstopdf-pkg'))"

# Enable using texlive fonts with xelatex
# advice as per https://github.com/matze/mtheme/issues/280#issuecomment-454041741
# and https://askubuntu.com/questions/1174423/how-can-i-make-the-ubuntu-see-latex-fonts-installed-through-texlive
# and https://tex.stackexchange.com/questions/257231/using-the-tex-live-fonts-in-xelatex/257232#257232
# basic file here http://www.tug.org/texlive///Contents/live/texmf-var/fonts/conf/texlive-fontconfig.conf
COPY 09-texlive-fonts.conf /etc/fonts/conf.d/09-texlive-fonts.conf
RUN fc-cache -fsv
