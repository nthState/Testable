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
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
  ],
  targets: [
    .plugin(
      name: "BuildPlugin",
      capability: .buildTool(),
      dependencies: []
    ),
    .target(
      name: "Testable",
      dependencies: [],
      plugins: [
        .plugin(name: "BuildPlugin")
      ]),
    .testTarget(
      name: "TestableTests",
      dependencies: ["Testable"],
      resources: [
        .copy("TestData")
      ]),
  ]
)
