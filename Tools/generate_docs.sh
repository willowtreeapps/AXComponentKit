#!/bin/sh

# cd to where this script lives, to avoid requiring it 
# to be executed from a predefined place
SCRIPT_PATH=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
cd "${SCRIPT_PATH}"

REPO_ROOT=$(cd ".."; pwd)
DOCS_ROOT="${REPO_ROOT}/docs"

rm -rf "${DOCS_ROOT}"
mkdir -p "${DOCS_ROOT}"

# -----------------------
# BEGIN INDEX FILE
# -----------------------

INDEX_FILE="${DOCS_ROOT}/index.html"
BASE_URL="https://willowtreeapps.github.io"

echo '<!DOCTYPE html>' > "${INDEX_FILE}"
echo '<html>' >> "${INDEX_FILE}"
echo '<body>' >> "${INDEX_FILE}"


#
# AXComponentKit
#

cd "${REPO_ROOT}"

DOCS_AXCOMPONENTKIT_FRAMEWORK_RELATIVE="framework"
DOCS_AXCOMPONENTKIT_FRAMEWORK_ROOT="${DOCS_ROOT}/${DOCS_AXCOMPONENTKIT_FRAMEWORK_RELATIVE}"
DOCS_AXCOMPONENTKIT_FRAMEWORK_RELATIVE_URL_PATH="AXComponentKit/${DOCS_AXCOMPONENTKIT_FRAMEWORK_RELATIVE}"

mkdir -p "${DOCS_AXCOMPONENTKIT_FRAMEWORK_ROOT}"
echo "	<a href=\"${BASE_URL}/${DOCS_AXCOMPONENTKIT_FRAMEWORK_RELATIVE_URL_PATH}/documentation/axcomponentkit\">AXComponentKit</a><br>" >> "${INDEX_FILE}"

xcodebuild clean docbuild \
    -scheme AXComponentKit \
    -destination generic/platform=iOS \
    OTHER_DOCC_FLAGS="--transform-for-static-hosting --hosting-base-path ${DOCS_AXCOMPONENTKIT_FRAMEWORK_RELATIVE_URL_PATH} --output-path ${DOCS_AXCOMPONENTKIT_FRAMEWORK_ROOT}"

#
# AXComponentKitTestSupport
#

cd "${AXCOMPONENTKIT_PACKAGE_ROOT}"

DOCS_AXCOMPONENTKITTESTSUPPORT_RELATIVE="testing"
DOCS_AXCOMPONENTKITTESTSUPPORT_ROOT="${DOCS_ROOT}/${DOCS_AXCOMPONENTKITTESTSUPPORT_RELATIVE}"
DOCS_AXCOMPONENTKITTESTSUPPORT_RELATIVE_URL_PATH="AXComponentKit/${DOCS_AXCOMPONENTKITTESTSUPPORT_RELATIVE}"

mkdir -p "${DOCS_AXCOMPONENTKITTESTSUPPORT_ROOT}"
echo "	<a href=\"${BASE_URL}/${DOCS_AXCOMPONENTKITTESTSUPPORT_RELATIVE_URL_PATH}/documentation/axcomponentkittestsupport\">AXComponentKit Test Support</a><br>" >> "${INDEX_FILE}"

xcodebuild clean docbuild \
    -scheme AXComponentKitTestSupport \
    -destination generic/platform=iOS \
 OTHER_DOCC_FLAGS="--transform-for-static-hosting --hosting-base-path ${DOCS_AXCOMPONENTKITTESTSUPPORT_RELATIVE_URL_PATH} --output-path ${DOCS_AXCOMPONENTKITTESTSUPPORT_ROOT}"


# -----------------------
# FINALIZE INDEX FILE
# -----------------------

echo '</body>' >> "${INDEX_FILE}"
echo '</html>' >> "${INDEX_FILE}"
