// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "FileSugar",
    products: [
        .library(
            name: "FileSugar",
            targets: ["FileSugar"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "FileSugar",
            dependencies: []),
        .testTarget(
            name: "FileSugarTests",
            dependencies: ["FileSugar"])
    ]
)
