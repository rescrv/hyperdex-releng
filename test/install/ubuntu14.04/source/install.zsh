#!/bin/zsh

set -e

mkdir -p /tmp/build
cd /tmp/build
cp /deps/*.tar.gz .

HYPERDEX_TARBALL=$(find $(pwd) -iname 'hyperdex*.tar.gz')
HYPERDEX="${HYPERDEX_TARBALL:t:r:r}"

tar xzvf ${HYPERDEX_TARBALL} --strip=3 ${HYPERDEX}/doc/install/source-install.sh
/bin/bash ./source-install.sh
