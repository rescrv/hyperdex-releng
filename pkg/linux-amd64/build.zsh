#!/bin/zsh

set -e

HYPERDEX_ROOT=$(basename ${MINION_ARTIFACT_DIST_HYPERDEX_TAR_GZ} | sed -e 's/.tar.gz//')
OUTPUT=/root/${HYPERDEX_ROOT}-linux-amd64.tar.gz

cd /tmp

export CUSTOM_PREFIX=/usr/local/hyperdex
export CUSTOM_CPPFLAGS="-I${CUSTOM_PREFIX}/include"
export CUSTOM_CFLAGS="-fPIC -fpic -O2"
export CUSTOM_CXXFLAGS="-fPIC -fpic -O2"
export CUSTOM_LDFLAGS="-L${CUSTOM_PREFIX}/lib -fPIC -fpic"
export CUSTOM_POPT_CFLAGS="-I${CUSTOM_PREFIX}/include"
export CUSTOM_POPT_LIBS="-L${CUSTOM_PREFIX}/lib /usr/local/hyperdex/lib/libpopt.a"
export CUSTOM_GLOG_CFLAGS="-I${CUSTOM_PREFIX}/include"
export CUSTOM_GLOG_LIBS="-L${CUSTOM_PREFIX}/lib /usr/local/hyperdex/lib/libglog.a"
export CUSTOM_PO6_CFLAGS="-I${CUSTOM_PREFIX}/include"
export CUSTOM_PO6_LIBS="-L${CUSTOM_PREFIX}/lib /usr/local/hyperdex/lib/libpo6.la"
export CUSTOM_E_CFLAGS="-I${CUSTOM_PREFIX}/include"
export CUSTOM_E_LIBS="-L${CUSTOM_PREFIX}/lib /usr/local/hyperdex/lib/libe.la"
export CUSTOM_TREADSTONE_CFLAGS="-I${CUSTOM_PREFIX}/include"
export CUSTOM_TREADSTONE_LIBS="-L${CUSTOM_PREFIX}/lib /usr/local/hyperdex/lib/libtreadstone.la"
export CUSTOM_BUSYBEE_CFLAGS="-I${CUSTOM_PREFIX}/include"
export CUSTOM_BUSYBEE_LIBS="-L${CUSTOM_PREFIX}/lib /usr/local/hyperdex/lib/libbusybee.la"
export CUSTOM_HYPERLEVELDB_CFLAGS="-I${CUSTOM_PREFIX}/include"
export CUSTOM_HYPERLEVELDB_LIBS="-L${CUSTOM_PREFIX}/lib /usr/local/hyperdex/lib/libhyperleveldb.la"
export CUSTOM_REPLICANT_CFLAGS="-I${CUSTOM_PREFIX}/include"
export CUSTOM_REPLICANT_LIBS="-L${CUSTOM_PREFIX}/lib /usr/local/hyperdex/lib/libreplicant.la"
export CUSTOM_SODIUM_CFLAGS="-I${CUSTOM_PREFIX}/include"
export CUSTOM_SODIUM_LIBS="-L${CUSTOM_PREFIX}/lib /usr/local/hyperdex/lib/libsodium.la"
export CUSTOM_MACAROONS_CFLAGS="-I${CUSTOM_PREFIX}/include ${CUSTOM_SODIUM_CFLAGS}"
export CUSTOM_MACAROONS_LIBS="-L${CUSTOM_PREFIX}/lib /usr/local/hyperdex/lib/libmacaroons.la ${CUSTOM_SODIUM_LIBS}"
export LIBTOOL_EXTRA_FLAGS="${CUSTOM_LDFLAGS}"

# build po6
cd /tmp
tar xzvf "${MINION_ARTIFACT_DIST_PO6_TAR_GZ}"
cd /tmp/libpo6*
./configure \
    CPPFLAGS="${CUSTOM_CPPFLAGS}" \
    CFLAGS="${CUSTOM_CFLAGS}" \
    CXXFLAGS="${CUSTOM_CXXFLAGS}" \
    LDFLAGS="${CUSTOM_LDFLAGS}" \
    --prefix=${CUSTOM_PREFIX}
make -j
make install

# build e
cd /tmp
tar xzvf "${MINION_ARTIFACT_DIST_E_TAR_GZ}"
cd /tmp/libe*
./configure \
    CPPFLAGS="${CUSTOM_CPPFLAGS}" \
    CFLAGS="${CUSTOM_CFLAGS}" \
    CXXFLAGS="${CUSTOM_CXXFLAGS}" \
    LDFLAGS="${CUSTOM_LDFLAGS}" \
    PO6_CFLAGS="${CUSTOM_PO6_CFLAGS}" \
    PO6_LIBS="${CUSTOM_PO6_LIBS}" \
    --prefix=${CUSTOM_PREFIX}
make -j
make install

# build BusyBee
cd /tmp
tar xzvf "${MINION_ARTIFACT_DIST_BUSYBEE_TAR_GZ}"
cd /tmp/busybee*
./configure \
    CPPFLAGS="${CUSTOM_CPPFLAGS}" \
    CFLAGS="${CUSTOM_CFLAGS}" \
    CXXFLAGS="${CUSTOM_CXXFLAGS}" \
    LDFLAGS="${CUSTOM_LDFLAGS}" \
    PO6_CFLAGS="${CUSTOM_PO6_CFLAGS}" \
    PO6_LIBS="${CUSTOM_PO6_LIBS}" \
    E_CFLAGS="${CUSTOM_E_CFLAGS}" \
    E_LIBS="${CUSTOM_E_LIBS}" \
    --prefix=${CUSTOM_PREFIX}
make -j
make install

# build HyperLevelDB
cd /tmp
tar xzvf "${MINION_ARTIFACT_DIST_LEVELDB_TAR_GZ}"
cd /tmp/hyperleveldb*
./configure \
    CPPFLAGS="${CUSTOM_CPPFLAGS}" \
    CFLAGS="${CUSTOM_CFLAGS}" \
    CXXFLAGS="${CUSTOM_CXXFLAGS}" \
    LDFLAGS="${CUSTOM_LDFLAGS}" \
    --prefix=${CUSTOM_PREFIX}
make -j
make install

# build popt
cd /tmp
tar xzvf "${MINION_SOURCE_POPT_TAR_GZ}"
cd /tmp/popt*
./configure \
    CPPFLAGS="${CUSTOM_CPPFLAGS}" \
    CFLAGS="${CUSTOM_CFLAGS}" \
    CXXFLAGS="${CUSTOM_CXXFLAGS}" \
    LDFLAGS="${CUSTOM_LDFLAGS}" \
    --disable-nls \
    --prefix=${CUSTOM_PREFIX}
make
make install

# build glog
cd /tmp
tar xzvf "${MINION_SOURCE_GLOG_TAR_GZ}"
cd /tmp/glog*
./configure \
    CPPFLAGS="${CUSTOM_CPPFLAGS}" \
    CFLAGS="${CUSTOM_CFLAGS}" \
    CXXFLAGS="${CUSTOM_CXXFLAGS}" \
    LDFLAGS="${CUSTOM_LDFLAGS}" \
    --prefix=${CUSTOM_PREFIX}
make
make install

# build sparsehash
cd /tmp
tar xzvf "${MINION_SOURCE_SPARSEHASH_TAR_GZ}"
cd /tmp/sparsehash*
./configure \
    CPPFLAGS="${CUSTOM_CPPFLAGS}" \
    CFLAGS="${CUSTOM_CFLAGS}" \
    CXXFLAGS="${CUSTOM_CXXFLAGS}" \
    LDFLAGS="${CUSTOM_LDFLAGS}" \
    --prefix=${CUSTOM_PREFIX}
make
make install

# build Replicant
cd /tmp
tar xzvf "${MINION_ARTIFACT_DIST_REPLICANT_TAR_GZ}"
cd /tmp/replicant*
./configure \
    CPPFLAGS="${CUSTOM_CPPFLAGS}" \
    CFLAGS="${CUSTOM_CFLAGS}" \
    CXXFLAGS="${CUSTOM_CXXFLAGS}" \
    LDFLAGS="${CUSTOM_LDFLAGS}" \
    POPT_CLFAGS="${CUSTOM_POPT_CFLAGS}" \
    POPT_LIBS="${CUSTOM_POPT_LIBS}" \
    PO6_CFLAGS="${CUSTOM_PO6_CFLAGS}" \
    PO6_LIBS="${CUSTOM_PO6_LIBS}" \
    E_CFLAGS="${CUSTOM_E_CFLAGS}" \
    E_LIBS="${CUSTOM_E_LIBS} -lrt" \
    BUSYBEE_CFLAGS="${CUSTOM_BUSYBEE_CFLAGS}" \
    BUSYBEE_LIBS="${CUSTOM_BUSYBEE_LIBS}" \
    HYPERLEVELDB_CFLAGS="${CUSTOM_HYPERLEVELDB_CFLAGS}" \
    HYPERLEVELDB_LIBS="${CUSTOM_HYPERLEVELDB_LIBS}" \
    --prefix=${CUSTOM_PREFIX}
make -j LDFLAGS="${CUSTOM_LDFLAGS} -static-libtool-libs" librsm.la
make -j libreplicant.la replicant-rsm-dlopen
make -j LDFLAGS="${CUSTOM_LDFLAGS} -static-libtool-libs" \
    replicant \
    replicant-kill-server \
    replicant-generate-unique-number \
    replicant-conn-str \
    replicant-del-object \
    replicant-backup-object \
    replicant-poke \
    replicant-debug-defended-call \
    replicant-kill-object \
    replicant-list-objects \
    replicant-debug \
    replicant-debug-call \
    replicant-debug-condition \
    replicant-daemon \
    replicant-restore-object \
    replicant-new-object
make install
chrpath -r '$ORIGIN/../lib' "${CUSTOM_PREFIX}"/libexec/replicant*/replicant-rsm-dlopen

# build sodium
cd /tmp
tar xzvf "${MINION_SOURCE_SODIUM_TAR_GZ}"
cd /tmp/libsodium*
sed -i -e 's/-fPIE/-fPIC/g' configure.ac configure ltmain.sh
./configure --disable-shared \
    CPPFLAGS="${CUSTOM_CPPFLAGS}" \
    CFLAGS="${CUSTOM_CFLAGS}" \
    CXXFLAGS="${CUSTOM_CXXFLAGS}" \
    LDFLAGS="${CUSTOM_LDFLAGS}" \
    --prefix=${CUSTOM_PREFIX}
make
make install

# build macaroons
cd /tmp
tar xzvf "${MINION_ARTIFACT_DIST_MACAROONS_TAR_GZ}"
cd /tmp/libmacaroons*
./configure \
    CPPFLAGS="${CUSTOM_CPPFLAGS}" \
    CFLAGS="${CUSTOM_CFLAGS}" \
    CXXFLAGS="${CUSTOM_CXXFLAGS}" \
    LDFLAGS="${CUSTOM_LDFLAGS}" \
    SODIUM_CFLAGS="${CUSTOM_SODIUM_CFLAGS}" \
    SODIUM_LIBS="${CUSTOM_SODIUM_LIBS}" \
    --prefix=${CUSTOM_PREFIX}
make -j
make install

# build Treadstone
cd /tmp
tar xzvf "${MINION_ARTIFACT_DIST_TREADSTONE_TAR_GZ}"
cd /tmp/libtreadstone*
./configure \
    CPPFLAGS="${CUSTOM_CPPFLAGS}" \
    CFLAGS="${CUSTOM_CFLAGS}" \
    CXXFLAGS="${CUSTOM_CXXFLAGS}" \
    LDFLAGS="${CUSTOM_LDFLAGS}" \
    PO6_CFLAGS="${CUSTOM_PO6_CFLAGS}" \
    PO6_LIBS="${CUSTOM_PO6_LIBS}" \
    E_CFLAGS="${CUSTOM_E_CFLAGS}" \
    E_LIBS="${CUSTOM_E_LIBS}" \
    --prefix=${CUSTOM_PREFIX}
make -j
make install

# build HyperDex
cd /tmp
tar xzvf "${MINION_ARTIFACT_DIST_HYPERDEX_TAR_GZ}"
cd /tmp/hyperdex*
./configure \
    CPPFLAGS="${CUSTOM_CPPFLAGS}" \
    CFLAGS="${CUSTOM_CFLAGS}" \
    CXXFLAGS="${CUSTOM_CXXFLAGS}" \
    LDFLAGS="${CUSTOM_LDFLAGS}" \
    POPT_CLFAGS="${CUSTOM_POPT_CFLAGS}" \
    POPT_LIBS="${CUSTOM_POPT_LIBS}" \
    GLOG_CLFAGS="${CUSTOM_GLOG_CFLAGS}" \
    GLOG_LIBS="${CUSTOM_GLOG_LIBS}" \
    PO6_CFLAGS="${CUSTOM_PO6_CFLAGS}" \
    PO6_LIBS="${CUSTOM_PO6_LIBS}" \
    E_CFLAGS="${CUSTOM_E_CFLAGS}" \
    E_LIBS="${CUSTOM_E_LIBS}" \
    BUSYBEE_CFLAGS="${CUSTOM_BUSYBEE_CFLAGS}" \
    BUSYBEE_LIBS="${CUSTOM_BUSYBEE_LIBS}" \
    HYPERLEVELDB_CFLAGS="${CUSTOM_HYPERLEVELDB_CFLAGS}" \
    HYPERLEVELDB_LIBS="${CUSTOM_HYPERLEVELDB_LIBS}" \
    REPLICANT_CFLAGS="${CUSTOM_REPLICANT_CFLAGS}" \
    REPLICANT_LIBS="${CUSTOM_REPLICANT_LIBS}" \
    SODIUM_CFLAGS="${CUSTOM_SODIUM_CFLAGS}" \
    SODIUM_LIBS="${CUSTOM_SODIUM_LIBS}" \
    MACAROONS_CFLAGS="${CUSTOM_MACAROONS_CFLAGS}" \
    MACAROONS_LIBS="${CUSTOM_MACAROONS_LIBS}" \
    TREADSTONE_CFLAGS="${CUSTOM_TREADSTONE_CFLAGS}" \
    TREADSTONE_LIBS="${CUSTOM_TREADSTONE_LIBS}" \
    --prefix=${CUSTOM_PREFIX}
sed -i -e 's/^link_all_deplibs=.*/link_all_deplibs=yes/g' libtool
make -j libhyperdex-admin.la
make -j LDFLAGS="${CUSTOM_LDFLAGS} -static-libtool-libs" \
    hyperdex \
    hyperdex-add-index \
    hyperdex-add-space \
    hyperdex-backup \
    hyperdex-backup-manager \
    hyperdex-coordinator \
    hyperdex-daemon \
    hyperdex-list-spaces \
    hyperdex-mv-space \
    hyperdex-perf-counters \
    hyperdex-raw-backup \
    hyperdex-rm-index \
    hyperdex-rm-space \
    hyperdex-server-forget \
    hyperdex-server-kill \
    hyperdex-server-offline \
    hyperdex-server-online \
    hyperdex-server-register \
    hyperdex-set-fault-tolerance \
    hyperdex-set-read-only \
    hyperdex-set-read-write \
    hyperdex-show-config \
    hyperdex-validate-space \
    hyperdex-wait-until-stable \
    libhyperdex-coordinator.la
make -j
make install

# cleanup and generate the tarball
rm -r "${CUSTOM_PREFIX}/include"
rm -r "${CUSTOM_PREFIX}/lib/pkgconfig"
rm "${CUSTOM_PREFIX}"/lib/libbusybee.*
rm "${CUSTOM_PREFIX}"/lib/libe.*
rm "${CUSTOM_PREFIX}"/lib/libglog.*
rm "${CUSTOM_PREFIX}"/lib/libhyperdex-admin.*
rm "${CUSTOM_PREFIX}"/lib/libhyperdex-client.*
rm "${CUSTOM_PREFIX}"/lib/libhyperleveldb.*
rm "${CUSTOM_PREFIX}"/lib/libmacaroons.*
rm "${CUSTOM_PREFIX}"/lib/libpopt.*
rm "${CUSTOM_PREFIX}"/lib/libreplicant.*
rm "${CUSTOM_PREFIX}"/lib/libtreadstone.*
rm "${CUSTOM_PREFIX}"/share/man/man3/popt.3
rm "${CUSTOM_PREFIX}"/libexec/hyperdex-*/libhyperdex-coordinator.a
rm "${CUSTOM_PREFIX}"/libexec/hyperdex-*/libhyperdex-coordinator.la
rmdir "${CUSTOM_PREFIX}"/share/java

tar czvf ${OUTPUT} -C /usr/local hyperdex/

# report

echo "================================================================================"
echo "Report on the various files shipped in the tarball, and what they link"
echo "================================================================================"

find "${CUSTOM_PREFIX}" -print0 \
| xargs -0 ldd 2>/dev/null \
| grep -v 'not a dynamic executable' \
| grep -v 'linux-vdso.so.1 =>' \
| grep -v 'libpthread.so.0 =>' \
| grep -v 'librt.so.1 =>' \
| grep -v 'libstdc++.so.6 =>' \
| grep -v 'libm.so.6 =>' \
| grep -v 'libgcc_s.so.1 =>' \
| grep -v 'libc.so.6 =>' \
| grep -v '/lib64/ld-linux-x86-64.so.2'

echo "================================================================================"
echo "SUCCESS"
echo "The built binaries are available at ${OUTPUT}"
echo "================================================================================"
echo MINION_ARTIFACT_PKG_LINUX_AMD64_TAR_GZ=${OUTPUT}
