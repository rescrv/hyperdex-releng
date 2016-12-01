#!/bin/zsh

set -e

PO6_BASE=$(basename $(echo ${MINION_ARTIFACT_DIST_PO6_TAR_GZ} | sed -e 's/.tar.gz//')).upack
cp /deps/releng/pkg/${PO6_BASE} /tmp
echo MINION_ARTIFACT_UPACK_PO6_PO6_UPACK=/tmp/${PO6_BASE}
