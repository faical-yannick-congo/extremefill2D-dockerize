From ubuntu:16.10

MAINTAINER Daniel Wheeler <daniel.wheeler2@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get install -y git && apt-get clean
RUN apt-get install -y sudo && apt-get clean
RUN apt-get install -y bzip2 && apt-get clean
RUN apt-get -y update
RUN apt-get install -y --fix-missing g++ && apt-get clean
RUN apt-get install -y libgfortran3 liblapack3 wget && apt-get clean
RUN apt-get install -y nano && apt-get clean

EXPOSE 8888

RUN mkdir /home/main

ENV HOME /home/main
ENV SHELL /bin/bash
WORKDIR $HOME

## Install FiPy Requirements

ENV ANACONDAPATH $HOME/anaconda
ENV PATH "$ANACONDAPATH/bin:${PATH}"

RUN wget https://repo.continuum.io/miniconda/Miniconda2-4.3.11-Linux-x86_64.sh
RUN bash Miniconda2-4.3.11-Linux-x86_64.sh -b -p $ANACONDAPATH
RUN conda update conda
RUN conda install libgfortran=1.0 && conda clean --all
RUN conda install matplotlib && conda clean --all
RUN conda install --channel guyer scipy gmsh && conda clean --all
RUN conda install --channel guyer pysparse openmpi mpi4py && conda clean --all
RUN conda install --channel guyer trilinos && conda clean --all

ENV PIP "pip --no-cache-dir"

RUN $PIP install scikit-fmm

RUN git config --global user.name "Main"
RUN git config --global user.email "main@main.com"


## Install Libibverbs for openmpi

RUN apt-get install -y libibverbs-dev

## Install FiPy

RUN git clone https://github.com/usnistgov/fipy
WORKDIR $HOME/fipy
RUN git checkout ecbe868f2aff6dbc43fb8ed532e581a03ebab5d5
RUN python setup.py develop

## Install Extremefill2D dependencies

WORKDIR $HOME

#RUN $PIP install sumatra==0.7.4
RUN git clone https://github.com/usnistgov/corr-sumatra.git
WORKDIR $HOME/corr-sumatra
Run git checkout corr-integrate
RUN python setup.py install

RUN apt-get install libsqlite3-dev

WORKDIR $HOME
RUN $PIP install configparser==3.5.0
RUN $PIP install gitpython==2.1.3
RUN $PIP install docopt==0.6.2
RUN $PIP install pandas==0.19.2
RUN $PIP install tables==3.3.0
RUN conda install jupyter=1.0.0 && conda clean --all
RUN conda install libgfortran=1.0 && conda clean --all
RUN $PIP install ipy_table==1.12
RUN $PIP install brewer2mpl==1.4.1

RUN rm $HOME/anaconda/lib/python2.7/site-packages/jinja2/asyncsupport.py

## Install Extremefill2D

WORKDIR $HOME
RUN git clone https://github.com/wd15/extremefill2D.git
WORKDIR $HOME/extremefill2D
RUN git checkout python2
RUN python setup.py develop

## Setup

EXPOSE 8888
EXPOSE 8000

ENV SHELL /bin/bash

VOLUME $HOME/work
WORKDIR $HOME/work