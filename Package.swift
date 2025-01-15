// swift-tools-version:5.9
import PackageDescription

// Define the package with a name and a list of products and dependencies
let package = Package(
    name: "FileSugar", // The name of the package
    platforms: [.iOS(.v17), .macOS(.v14)], // Platforms the package supports
    products: [
        .library( // Define a library product
            name: "FileSugar", // The name of the library product
            targets: ["FileSugar"]) // The targets that make up the product
    ],
    dependencies: [ // The list of dependencies for the package
    ],
    targets: [ // The list of targets for the package
        .target( // Define a target
            name: "FileSugar", // The name of the target
            dependencies: []), // The dependencies of the target
        .testTarget( // Define a test target
            name: "FileSugarTests", // The name of the test target
            dependencies: ["FileSugar"] // The dependencies of the test target
        ),
        .testTarget( // Define a test target
            name: "FileModifierTests", // The name of the test target
            dependencies: ["FileSugar"] // The dependencies of the test target
        ),
        .testTarget( // Define a test target
            name: "FileStreamTests", // The name of the test target
            dependencies: ["FileSugar"] // The dependencies of the test target
         ),
        .testTarget(
            name: "FileParserTests",
            dependencies: ["FileSugar"],
            // sources: ["FileParserTests.swift"],
            resources: [
                .copy("Resources/TestResource.txt")
            ]
        )

    ]
)
