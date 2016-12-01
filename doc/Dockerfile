FROM        rescrv/texlive-2015
MAINTAINER  robert@hyperdex.org

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN apt-get update
RUN apt-get install -y ghostscript git make python python-ply python-pygments python-setuptools python-chardet
RUN easy_install-2.7 crosstex
RUN easy_install-2.7 BeautifulSoup4
WORKDIR /tmp
RUN git clone git://github.com/rescrv/crosstex-dbgen.git
WORKDIR /tmp/crosstex-dbgen
RUN make install-local install-global
ADD html.py /root/html.py
ADD build.zsh /root/build.zsh
ADD pgfsys-tex4ht.def /usr/local/texlive/2015/texmf-dist/tex/generic/pgf/systemlayer/pgfsys-tex4ht.def

CMD /root/build.zsh
