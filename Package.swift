// swift-tools-version:5.6
import PackageDescription

// Define the package with a name and a list of products and dependencies
let package = Package(
    name: "FileSugar", // The name of the package
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
            dependencies: ["FileSugar"]) // The dependencies of the test target
    ]
)
