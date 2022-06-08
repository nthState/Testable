// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Testable",
  platforms: [.iOS(.v15), .macOS(.v10_15)],
  products: [
    .library(
      name: "Testable",
      targets: ["Testable"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Testable",
      dependencies: []),
    .testTarget(
      name: "TestableTests",
      dependencies: ["Testable"],
      resources: [
        .copy("TestData")
      ]),
  ]
)
