#!/bin/zsh

set -e

REPLICANT_BASE=$(basename $(echo ${MINION_ARTIFACT_DIST_REPLICANT_TAR_GZ} | sed -e 's/.tar.gz//')).upack
cp /deps/releng/pkg/${REPLICANT_BASE} /tmp
echo MINION_ARTIFACT_UPACK_REPLICANT_REPLICANT_UPACK=/tmp/${REPLICANT_BASE}
