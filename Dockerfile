FROM jupyter/minimal-notebook:8d22c86ed4d7
MAINTAINER Kacper Kowalik <xarthisius.kk@gmail.com>
RUN conda install -q -y -c conda-forge yt scipy astropy pandas scikit-learn xlrd && conda clean -tipsy
RUN ipython -c 'from matplotlib.font_manager import FontManager; FontManager()'
RUN conda install -q -y bokeh && conda clean -tipsy
RUN pip install bash_kernel && python -m bash_kernel.install --user
RUN bokeh sampledata
RUN jupyter notebook --generate-config -y   # takes care of permissions

COPY ./jupyter_notebook_config.py /home/jovyan/.jupyter/jupyter_notebook_config.py
COPY ./custom.js /home/jovyan/.jupyter/custom/custom.js
WORKDIR /home/jovyan/work

COPY ./watchdog.py /tmp/watchdog.py
HEALTHCHECK --interval=5s --timeout=15s --start-period=5s CMD python3 /tmp/watchdog.py
