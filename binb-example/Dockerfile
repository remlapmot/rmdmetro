FROM rmdmetro
RUN mkdir /home/binb-example
COPY example.R /home/binb-example/example.R
CMD cd /home/binb-example \ 
    && R < example.R --no-save
