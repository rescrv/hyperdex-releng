FROM        ubuntu:14.04
MAINTAINER  robert@hyperdex.org

RUN apt-get update
RUN apt-get install -y wget zsh
RUN apt-get install -y build-essential
RUN apt-get install -y python
ADD install.zsh /tmp/install.zsh
ADD discover-addresses.c /tmp/discover-addresses.c
RUN gcc -o /tmp/discover-addresses /tmp/discover-addresses.c
RUN /tmp/install.zsh
ADD run.zsh /tmp/run.zsh

CMD /tmp/run.zsh
