// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Dependencies",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Dependencies",
            targets: ["Dependencies"]
        ),
    ],
    dependencies: [
        .package(path: "PortalGun"),
        .package(path: "Components")
    ],
    targets: [
        .target(
            name: "Dependencies",
            dependencies: [
                .product(name: "PortalGun", package: "PortalGun"),
                .product(name: "PortalGunMocks", package: "PortalGun"),
                .product(name: "Components", package: "Components")
            ]
        )
    ]
)
