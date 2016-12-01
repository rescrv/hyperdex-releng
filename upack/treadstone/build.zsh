#!/bin/zsh

set -e

TREADSTONE_BASE=$(basename $(echo ${MINION_ARTIFACT_DIST_TREADSTONE_TAR_GZ} | sed -e 's/.tar.gz//')).upack
cp /deps/releng/pkg/${TREADSTONE_BASE} /tmp
echo MINION_ARTIFACT_UPACK_TREADSTONE_TREADSTONE_UPACK=/tmp/${TREADSTONE_BASE}
