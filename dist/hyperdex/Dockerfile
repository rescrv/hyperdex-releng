FROM        rescrv/dist
MAINTAINER  robert@hyperdex.org

RUN apt-get update
RUN apt-get install -y libpopt-dev libgoogle-glog-dev
RUN apt-get install -y python-dev
RUN apt-get install -y ruby-dev
RUN apt-get install -y default-jdk
RUN apt-get install -y junit4
RUN apt-get install -y libbsd-dev
ADD build.sh /root/build.sh
CMD /root/build.sh
