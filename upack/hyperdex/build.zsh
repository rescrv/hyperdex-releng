#!/bin/zsh

set -e

HYPERDEX_BASE=$(basename $(echo ${MINION_ARTIFACT_DIST_HYPERDEX_TAR_GZ} | sed -e 's/.tar.gz//')).upack
cp /deps/releng/pkg/${HYPERDEX_BASE} /tmp
echo MINION_ARTIFACT_UPACK_HYPERDEX_HYPERDEX_UPACK=/tmp/${HYPERDEX_BASE}
