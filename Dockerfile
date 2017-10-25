FROM jupyter/minimal-notebook:latest
MAINTAINER Kacper Kowalik <xarthisius.kk@gmail.com>
RUN conda install -c conda-forge yt scipy astropy pandas scikit-learn
