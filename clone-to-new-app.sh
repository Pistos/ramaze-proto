#!/bin/bash

set -e

if [ $# -lt 1 ]
then
  echo "Usage: `basename $0` <dir of new repo>"
  exit 1
fi

DEST_DIR=${1}

echo "Creating new Ramaze application at ${DEST_DIR}..."

mkdir -p ${DEST_DIR}
pushd ${DEST_DIR}
git init
popd
git archive master | tar -x -C ${DEST_DIR}
cd ${DEST_DIR}

echo '... done!'
