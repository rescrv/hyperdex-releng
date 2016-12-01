#!/bin/zsh

set -e

LEVELDB_BASE=$(basename $(echo ${MINION_ARTIFACT_DIST_LEVELDB_TAR_GZ} | sed -e 's/.tar.gz//')).upack
cp /deps/releng/pkg/${LEVELDB_BASE} /tmp
echo MINION_ARTIFACT_UPACK_LEVELDB_LEVELDB_UPACK=/tmp/${LEVELDB_BASE}
