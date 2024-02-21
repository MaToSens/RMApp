// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Database",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Database",
            targets: ["Database"]
        ),
        .library(
            name: "DatabaseInterface",
            targets: ["DatabaseInterface"]
        ),
    ],
    dependencies: [
        .package(path: "../DependencyInjection"),
        .package(url: "https://github.com/realm/realm-swift", exact: "10.47.0")
    ],
    targets: [
        .target(
            name: "DatabaseInterface",
            dependencies: [
                .product(
                    name: "RealmSwift",
                    package: "realm-swift"
                )
            ]
        ),
        .target(
            name: "Database",
            dependencies: [
                "DatabaseInterface",
                .product(
                    name: "DependencyInjection",
                    package: "DependencyInjection"
                )
            ]
        ),
    ]
)
