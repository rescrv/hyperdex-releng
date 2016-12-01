#!/bin/zsh

setopt err_exit

WORKDIR=/tmp/upack
ARCHIVE=${WORKDIR}/archive
OUTPUT=${WORKDIR}/output

# Prepare the archive of dependencies
mkdir -p ${ARCHIVE}
if test -n  "$(find /deps/ -maxdepth 2 -name '*pkgs.tar.gz' -print -quit)"
then
    for x in /deps/**/*pkgs.tar.gz
    do
        tar xzvf ${x} -C ${ARCHIVE}
    done
fi
createrepo ${ARCHIVE}

# Run upack
mkdir -p ${OUTPUT}
chown mock:mock ${OUTPUT}
cd ${WORKDIR}
upack -t fedora -t rpm -t centos7 -t centos-7 rpm /deps/*.upack

# Make srpm
mkdir SOURCES
cp /deps/*.tar.gz SOURCES
rpmbuild --define='%_topdir .' -bs *.spec

# Run mock
cp /etc/mock/* .
cp /root/default.cfg .
sed -i -e s,XXXBASEURLXXX,${ARCHIVE}, default.cfg
sleep 1
find /var -type f -iname '*cache.tar*' -exec touch {} \;

unsetopt err_exit

su -c "/usr/bin/mock -r default --resultdir=${OUTPUT} --configdir=${WORKDIR} ${WORKDIR}/SRPMS/*.src.rpm" mock
if [ $? -ne 0 ]; then
    cat /tmp/upack/output/build.log
    exit 1
fi

setopt err_exit

# Copy results
chown -R root:root ${OUTPUT}
tar czvf /tmp/pkgs.tar.gz -C ${OUTPUT} .

# Echo the Artifact
echo ${ARTIFACT_NAME}=/tmp/pkgs.tar.gz
