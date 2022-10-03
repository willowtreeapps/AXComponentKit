#!/bin/sh

DOCS_BASE_DIR="docs"

cd ..

rm -rf "${DOCS_BASE_DIR}"
mkdir -p "${DOCS_BASE_DIR}"

xcodebuild clean docbuild \
    -scheme AXComponentKit \
    -destination generic/platform=iOS \
    OTHER_DOCC_FLAGS="--transform-for-static-hosting --hosting-base-path framework/ --output-path ${DOCS_BASE_DIR}/framework/"

xcodebuild clean docbuild \
    -scheme AXComponentKitTestSupport \
    -destination generic/platform=iOS \
 OTHER_DOCC_FLAGS="--transform-for-static-hosting --hosting-base-path testing/ --output-path ${DOCS_BASE_DIR}/testing/"
