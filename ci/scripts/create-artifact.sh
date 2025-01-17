#!/bin/sh

# Ensure this script fails if anything errors
set -e

CWD=$(pwd)
BINARY=janus

# Goes to the application source code
cd source-code/
# Creates the project source on the gopath
mkdir -p ${PROJECT_SRC}
# Copies the current source code from the app to the gopath
cp -r . ${PROJECT_SRC}
# Goes to the application on the gopath
cd ${PROJECT_SRC}
# Build the go application
make
# Goes to the generated go binaries
cd out/

echo "Creating tar.gz"
tar -C darwin_amd64 -czf darwin_amd64.tar.gz ${BINARY}
tar -C linux_amd64 -czf linux_amd64.tar.gz ${BINARY}

# Copies the tar to the artifact folder so its available to the next step of the pipeline
echo "Copying *.tar.gz ${CWD}/artifacts"
cp *.tar.gz ${CWD}/artifacts
