FROM        debian:6
MAINTAINER  robert@hyperdex.org

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y build-essential chrpath python zsh

ADD build.zsh /root/build.zsh

CMD /root/build.zsh
