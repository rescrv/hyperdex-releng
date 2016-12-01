#!/bin/zsh

set -e

E_BASE=$(basename $(echo ${MINION_ARTIFACT_DIST_E_TAR_GZ} | sed -e 's/.tar.gz//')).upack
cp /deps/releng/pkg/${E_BASE} /tmp
echo MINION_ARTIFACT_UPACK_E_E_UPACK=/tmp/${E_BASE}
