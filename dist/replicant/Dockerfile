FROM        rescrv/dist
MAINTAINER  robert@hyperdex.org

RUN apt-get update
RUN apt-get install -y libpopt-dev libgoogle-glog-dev
RUN apt-get install -y libsparsehash-dev valgrind
ADD build.sh /root/build.sh
CMD /root/build.sh
