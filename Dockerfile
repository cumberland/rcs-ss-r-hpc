FROM r-base

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y libmysqlclient-dev libcurl4-openssl-dev libssl-dev 


RUN echo 'install.packages("RMariaDB", repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R \
    && Rscript /tmp/packages.R


RUN useradd --create-home --home-dir /home/user user && chown -R user:user $HOME

WORKDIR /home/user/src
USER user

#Add the Code Directory.
CMD mkdir /home/user/src

COPY src/* /home/user/src/ 

# set the command
CMD ["Rscript","--no-save","/home/user/src/runner.R"]


