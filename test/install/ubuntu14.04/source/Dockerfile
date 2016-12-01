FROM        rescrv/dist
MAINTAINER  robert@hyperdex.org

RUN apt-get update
RUN apt-get install -y tar zsh
RUN apt-get install -y libpopt-dev libgoogle-glog-dev
RUN apt-get install -y libsparsehash-dev
RUN apt-get install -y wget
RUN wget https://github.com/jedisct1/libsodium/releases/download/1.0.0/libsodium-1.0.0.tar.gz
RUN tar xzvf libsodium-1.0.0.tar.gz
RUN (cd libsodium-1.0.0 && ./configure && make && make install)
ADD install.zsh /root/install.zsh

CMD /root/install.zsh
