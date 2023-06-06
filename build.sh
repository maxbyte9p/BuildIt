#!/bin/bash

set -e

cat << EOF
## Prepping buildit directory...
EOF
set -x

mkdir -pv ./buildit/bin

set +x
cat << EOF
## Building external tools...
EOF
set -x

cd ./src/external-tools/bubblewrap-0.8.0; sh autogen.sh && make -j$(nproc) && cp bwrap ../../../buildit/bin
cd ../../../
make -j$(nproc) -C ./src/external-tools/mk && cp ./src/external-tools/mk/mk/mk ./buildit/bin

set +x
cat << EOF
## Fetching and placing internal tools where they need to go...
EOF
set -x

cp -r ./src/configs/bash ./buildit
cp ./src/internal-tools/buildit-shell ./buildit
cp -r ./src/internal-tools/mktools ./buildit
cp ./src/mkfiles/stages.mk ./buildit
cp -r ./src/mkfiles/pkgs ./buildit

set +x
cat << EOF
## Done.
EOF