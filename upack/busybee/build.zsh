#!/bin/zsh

set -e

BUSYBEE_BASE=$(basename $(echo ${MINION_ARTIFACT_DIST_BUSYBEE_TAR_GZ} | sed -e 's/.tar.gz//')).upack
cp /deps/releng/pkg/${BUSYBEE_BASE} /tmp
echo MINION_ARTIFACT_UPACK_BUSYBEE_BUSYBEE_UPACK=/tmp/${BUSYBEE_BASE}
