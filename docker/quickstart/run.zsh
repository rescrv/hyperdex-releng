#!/bin/zsh

set -e

HOST=`/tmp/discover-addresses | grep -v '^lo' | awk '{print $2}' | grep -v '^254' | head -1`

if test -z "${HOST}"; then
    echo 'could not discover the IP address'
    exit 1
fi

mkdir -p /tmp/coord
mkdir -p /tmp/daemon

hyperdex coordinator --foreground --listen ${HOST} --data /tmp/coord 2>&1 \
| stdbuf -o L sed -e 's/^/coordinator: /' &
sleep 1
hyperdex daemon --foreground --listen ${HOST} --coordinator ${HOST} --data /tmp/daemon 2>&1 \
| stdbuf -o L sed -e 's/^/daemon: /' &
sleep 1

echo "The transient HyperDex cluster is now online."

while true;
do
    echo
    echo "This is a transient HyperDex cluster."
    echo "You can connect to this cluster at address=${HOST}, port=1982."
    echo
    echo "If you're looking to play with HyperDex, open another terminal"
    echo "and run the following command to get a Python shell, where you"
    echo " may follow along with the tutorials at http://hyperdex.org/"
    echo
    echo "    docker run -t -i hyperdex/quickstart /usr/bin/python"
    echo
    sleep 60
done
