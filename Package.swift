// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CodableBenchmarks",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CodableBenchmarks",
            targets: ["CodableBenchmarks"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/SomeRandomiOSDev/CBORCoding.git", from: "1.0.0"),
        .package(url: "https://github.com/christophhagen/BinaryCodable", from: "1.0.0"),
        .package(url: "https://github.com/outfoxx/PotentCodables.git", from: "1.0.0"),
        .package(url: "https://github.com/hirotakan/MessagePacker.git", from: "0.4.7"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CodableBenchmarks",
            dependencies: []),
        .testTarget(
            name: "CodableBenchmarksTests",
            dependencies: ["CodableBenchmarks", "CBORCoding", "BinaryCodable", "PotentCodables", "MessagePacker"],
            resources: [.copy("Fixtures")]),
    ]
)
