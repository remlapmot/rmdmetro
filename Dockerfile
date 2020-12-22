FROM rocker/verse

# install Fira Code
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
RUN apt-get update && \
    apt-get install fonts-firacode

# install fira (Fira Sans and Fira Mono) and firamath (Fira Math)
RUN apt-get update && \
    apt-get install -y texlive-fonts-extra

RUN R -e "tinytex::tlmgr_update()"
RUN R -e "tinytex::tlmgr_install('firamath')"
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
# RUN wget "http://www.tug.org/texlive///Contents/live/texmf-var/fonts/conf/texlive-fontconfig.conf" && \
#   mv texlive-fontconfig.conf /etc/fonts/conf.d/09-texlive-fonts.conf
COPY 09-texlive-fonts.conf /etc/fonts/conf.d/09-texlive-fonts.conf
RUN fc-cache -fsv
