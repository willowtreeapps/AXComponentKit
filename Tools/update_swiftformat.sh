#!/bin/sh

PACKAGE_MANIFEST=$(cat <<-END
// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "BuildTools",
    platforms: [.macOS(.v10_11)],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.49.0"),
    ],
    targets: [.target(name: "BuildTools", path: "")]
)
END
)

mkdir -p swiftformat_tmp
cd swiftformat_tmp
echo "$PACKAGE_MANIFEST" > Package.swift
echo "" > Empty.swift

SDKROOT=(xcrun --sdk macosx --show-sdk-path)
swift package update
cp .build/checkouts/SwiftFormat/CommandLineTool/swiftformat ../swiftformat
cd ..
rm -rf swiftformat_tmp