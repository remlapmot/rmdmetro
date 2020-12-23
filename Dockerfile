ARG R=latest

# LABEL maintainer="Tom Palmer <remlapmot@hotmail.com>" \
#       org.opencontainers.image.authors="Tom Palmer" \
#       author.orcid="0000-0003-4655-4511" \
#       org.opencontainers.image.url="https://hub.docker.com/repository/docker/remlapmot/rmdmetropolis" \
#       org.label-schema.vcs-url="https://github.com/remlapmot/rmdmetropolis" \
#       org.label-schema.license="GPL-2.0"

FROM rocker/verse:${R}

RUN apt-get update --fix-missing

# install Fira Code
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
RUN apt-get update && \
    apt-get install fonts-firacode

# install Fira Sans and Fira Mono
RUN apt-get install -y texlive-fonts-extra

# update texlive manager
RUN R -e "tinytex::tlmgr_update()"

# alternative code to install Fira Sans and Fira Mono
# RUN R -e "tinytex::tlmgr_install('fira')" # not required

# install Fira Math
RUN R -e "tinytex::tlmgr_install('firamath')"

# install additional required texlive packages
RUN R -e "tinytex::tlmgr_install('beamer')"
RUN R -e "tinytex::tlmgr_install('beamertheme-metropolis')"
RUN R -e "tinytex::tlmgr_install('infwarerr')"
RUN R -e "tinytex::tlmgr_install('kvoptions')"
RUN R -e "tinytex::tlmgr_install('euenc')"
RUN R -e "tinytex::tlmgr_install('fontspec')"
RUN R -e "tinytex::tlmgr_install('unicode-math')"
RUN R -e "tinytex::tlmgr_install('xunicode')"
RUN R -e "tinytex::tlmgr_install('pgfopts')"
RUN R -e "tinytex::tlmgr_install('appendixnumberbeamer')"
RUN R -e "tinytex::tlmgr_install('biblatex-chicago')"
RUN R -e "tinytex::tlmgr_install('xstring')"
RUN R -e "tinytex::tlmgr_install('logreq')"
RUN R -e "tinytex::tlmgr_install('biblatex')"
RUN R -e "tinytex::tlmgr_install('biber')"
RUN R -e "tinytex::tlmgr_install('fancyvrb')"
RUN R -e "tinytex::tlmgr_install('framed')"
RUN R -e "tinytex::tlmgr_install('booktabs')"
RUN R -e "tinytex::tlmgr_install('caption')"

# enable using texlive fonts with xelatex
# advice as per https://github.com/matze/mtheme/issues/280#issuecomment-454041741
# and https://askubuntu.com/questions/1174423/how-can-i-make-the-ubuntu-see-latex-fonts-installed-through-texlive
# and https://tex.stackexchange.com/questions/257231/using-the-tex-live-fonts-in-xelatex/257232#257232
# basic file here http://www.tug.org/texlive///Contents/live/texmf-var/fonts/conf/texlive-fontconfig.conf
ENV conffile=/etc/fonts/conf.d/09-texlive-fonts.conf
RUN echo '<?xml version="1.0"?>' > $conffile
RUN echo '<!DOCTYPE fontconfig SYSTEM "fonts.dtd">' >> $conffile
RUN echo '<fontconfig>' >> $conffile
RUN echo '<dir>/usr/share/texlive/texmf-dist/fonts/opentype</dir>' >> $conffile
RUN echo '<dir>/usr/share/texlive/texmf-dist/fonts/truetype</dir>' >> $conffile
RUN echo '<dir>/usr/share/texlive/texmf-dist/fonts/type1</dir>' >> $conffile
RUN echo '<dir>/usr/local/texlive/texmf-local/fonts/opentype</dir>' >> $conffile
RUN echo '<dir>/usr/local/texlive/texmf-local/fonts/truetype</dir>' >> $conffile
RUN echo '<dir>/usr/local/texlive/texmf-local/fonts/type1</dir>' >> $conffile
RUN echo '<dir>/usr/local/texlive/texmf-dist/fonts/type1</dir>' >> $conffile
RUN echo '<dir>/opt/texlive/texmf-local/fonts/opentype</dir>' >> $conffile
RUN echo '<dir>/opt/texlive/texmf-local/fonts/type1</dir>' >> $conffile
RUN echo '</fontconfig>' >> $conffile
RUN fc-cache -fsv
