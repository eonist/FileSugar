// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "FileSugar",
    products: [
        .library(
            name: "FileSugar",
            platforms: [.iOS(.v12), .macOS(.v10_13)],
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
