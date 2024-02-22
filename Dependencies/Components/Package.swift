// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Components",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Components",
            targets: ["Components"]
        ),
    ],
    dependencies: [
        .package(path: "../Design")
    ],
    targets: [
        .target(
            name: "Components",
            dependencies: [.product(name: "Design", package: "Design")]
        ),
    ]
)
