# FileSugar

[![Tests](https://github.com/eonist/FileSugar/actions/workflows/Tests.yml/badge.svg)](https://github.com/eonist/FileSugar/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/b4b79239-d1f9-4c9a-8c46-d6a1b9dcb559)](https://codebeat.co/projects/github-com-eonist-filesugar-master)

### Description
FileSugar is a lightweight Swift package that provides an elegant API for file system operations in iOS and macOS. It simplifies common tasks like reading, writing, and managing files while maintaining type-safety and performance.

## Table of Contents
- [Description](#description)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)

## Features

- Open, save, delete, copy, move, and create files and directories
- Stream reading and writing support for handling large files efficiently
- Asynchronous file operations with `async`/`await`
- File path utilities for normalizing and expanding paths
- XML parsing capabilities on macOS
- Simple and consistent API for file system interactions

## Installation

You can install FileSugar using Swift Package Manager. Simply add the following line to your `Package.swift` file:

```swift
.package(url: "https://github.com/eonist/FileSugar.git", .branch("master"))

### Usage
Here are some examples of how to use FileSugar:
```swift
// Write text to a file
let success = FileModifier.write("~/Desktop/temp.txt".tildePath, content: "Hello, World!")

// Write data to a file
let data = Data([0x00, 0x01, 0x02])
let dataWritten = try FileModifier.write(path: "~/Desktop/data.bin".tildePath, data: data)

// Read text content from a file
if let content = FileParser.content(filePath: "~/Desktop/temp.txt".tildePath) {
    print(content)
}

// Read data from a file
if let data = FileParser.data(filePath: "~/Desktop/data.bin".tildePath) {
    // Process data
}

// Asynchronously read content from a file
Task {
    do {
        let content = try await FileParser.readContentAsync(url: URL(fileURLWithPath: "~/Desktop/temp.txt".tildePath))
        print(content)
    } catch {
        print("Error reading file: \(error)")
    }
}

// Asynchronously write content to a file
Task {
    do {
        try await FileModifier.writeContentAsync(url: URL(fileURLWithPath: "~/Desktop/temp.txt".tildePath), content: "Async write")
    } catch {
        print("Error writing file: \(error)")
    }
}

// Move a file
let moved = FileModifier.move("~/Desktop/source.txt".tildePath, toURL: "~/Desktop/destination.txt".tildePath)

// Copy a file
let copied = FileModifier.copy("~/Desktop/source.txt".tildePath, toURL: "~/Desktop/copy.txt".tildePath)

// Delete a file
let deleted = FileModifier.delete("~/Desktop/temp.txt".tildePath)

// Create a directory
let dirCreated = FileModifier.createDir(path: "~/Desktop/NewFolder".tildePath)

// Write data to a file at a specific index
let data = "Partial".data(using: .utf8)!
try FileStreamWriter.write(filePath: "~/Desktop/stream.txt".tildePath, data: data, index: 5)

// Read data from a file starting at a specific index
let readData = try FileStreamReader.read(filePath: "~/Desktop/stream.txt".tildePath, startIndex: 5, endIndex: 10)

// Normalize a file path
if let normalizedPath = FilePathModifier.normalize("~/Desktop/../Documents/file.txt") {
    print(normalizedPath) // Outputs the absolute path
}

// Expand a relative file path
if let expandedPath = FilePathModifier.expand("file.txt", baseURL: "~/Desktop") {
    print(expandedPath)
}
```

### Contributing
If you find a bug or have a feature request, please open an issue on GitHub. Pull requests are also welcome!

### License
FileSugar is available under the MIT license. See the LICENSE file for more info.

### Improvements
- Add test file in spm resource .bundle
- Move FileStreamer into it's own repo again?
- Add more examples to readme?

## Platforms

- iOS 17 or later
- macOS 14 or later
