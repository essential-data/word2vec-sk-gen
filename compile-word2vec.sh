#!/bin/sh
cd trunk
if [ "$(uname)" == 'Darwin' ]; then patch -p1 < ../word2vec-patch-osx.diff; fi
make
cd ..
