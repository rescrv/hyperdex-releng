#!/bin/zsh

set -e

MACAROONS_BASE=$(basename $(echo ${MINION_ARTIFACT_DIST_MACAROONS_TAR_GZ} | sed -e 's/.tar.gz//')).upack
cp /deps/releng/pkg/${MACAROONS_BASE} /tmp
echo MINION_ARTIFACT_UPACK_MACAROONS_MACAROONS_UPACK=/tmp/${MACAROONS_BASE}
