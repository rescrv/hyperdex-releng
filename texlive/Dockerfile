FROM        ubuntu:14.04
MAINTAINER  robert@hyperdex.org

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
RUN apt-get update
RUN apt-get install -y zsh wget
ADD texlive2015.iso.sha256 /root/texlive2015.iso.sha256
ADD build.zsh /root/build.zsh

CMD /root/build.zsh
