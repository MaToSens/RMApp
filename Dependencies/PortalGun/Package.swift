// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "PortalGun",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "PortalGun",
            targets: ["PortalGun"]
        ),
        .library(
            name: "PortalGunInterface",
            targets: ["PortalGunInterface"]
        ),
        .library(
            name: "PortalGunMocks",
            targets: ["PortalGunMocks"]
        ),
    ],
    dependencies: [
        .package(path: "../Backend"),
        .package(path: "../Database"),
        .package(path: "../DependencyInjection")
    ],
    targets: [
        .target(
            name: "PortalGunInterface",
            dependencies: [
                .product(name: "Backend", package: "Backend"),
                .product(name: "DependencyInjection", package: "DependencyInjection"),
                .product(name: "Database", package: "Database")
            ]
        ),
        .target(
            name: "PortalGun",
            dependencies: ["PortalGunInterface"]
        ),
        .target(
            name: "PortalGunMocks",
            dependencies: ["PortalGun"]
        ),
        .testTarget(
            name: "PortalGunTests",
            dependencies: ["PortalGun"]
        ),
    ]
)
