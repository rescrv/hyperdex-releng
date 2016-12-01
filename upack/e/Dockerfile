FROM        ubuntu:14.04
MAINTAINER  robert@hyperdex.org

RUN apt-get update
RUN apt-get install -y python python-setuptools python-ply zsh
RUN easy_install-2.7 --upgrade upack
ADD build.zsh /root/build.zsh

CMD /root/build.zsh
