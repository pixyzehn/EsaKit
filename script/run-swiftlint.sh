#!/usr/bin/env bash

set -e

if ! which swiftlint > /dev/null; then
  echo "warning: SwiftLint is not installed. Vistit http://github.com/realm/SwiftLint to learn more."
  exit 1
fi

swiftlint

