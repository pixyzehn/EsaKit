#!/usr/bin/env bash

# Ref: https://github.com/inamiy/VTree/blob/master/Scripts/generate-message.sh
# https://github.com/krzysztofzablocki/Sourcery
SOURCERY_VER=0.5.8

CMD=`basename $0`

getopts "a:" OPTS
ARG=$OPTARG
shift $((OPTIND-1))

if [[ $# -ne 2 ]]; then
  echo "Usage: $CMD <source-dir> <code-generated-dir>" 1>&2
  exit 1
fi

DIR=`dirname $0`
SOURCE_DIR=$1
OUTPUT_DIR=$2

# Download Sourcery if needed.
if [[ ! -x $DIR/sourcery/bin/sourcery ]]; then
    echo "Downloading sourcery-$SOURCERY_VER..."
    curl -L -O https://github.com/krzysztofzablocki/Sourcery/releases/download/$SOURCERY_VER/sourcery-$SOURCERY_VER.zip
    unzip sourcery-$SOURCERY_VER.zip -d $DIR/sourcery
    rm sourcery-$SOURCERY_VER.zip
fi

# Copy EsaKit code (temporarily) to source directory
# so that SourceKitten can find types.
mkdir -p "$SOURCE_DIR"/_EsaKitGenerated
cp "$DIR"/../Sources/EsaKit/**/*.swift "$SOURCE_DIR"/_EsaKitGenerated/

# Run Sourcery.
$DIR/sourcery/bin/sourcery "$SOURCE_DIR"/_EsaKitGenerated/ "$DIR"/../Templates "$OUTPUT_DIR" --args "$ARG"

STATUS=$?

rm -rf "$SOURCE_DIR"/_EsaKitGenerated

exit $STATUS

