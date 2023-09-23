# FileSugar

[![Tests](https://github.com/eonist/FileSugar/actions/workflows/Tests.yml/badge.svg)](https://github.com/eonist/FileSugar/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/b4b79239-d1f9-4c9a-8c46-d6a1b9dcb559)](https://codebeat.co/projects/github-com-eonist-filesugar-master)

### Description
FileSugar is a Swift package that provides a simple API for working with files. It allows you to easily open, save, delete, and create files.

## Table of Contents
- [Description](#description)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)

## Features

- Open, save, delete, and create files
- Simple API for working with files

## Installation

You can install FileSugar using Swift Package Manager. Simply add the following line to your `Package.swift` file:

```swift
.package(url: "https://github.com/eonist/FileSugar.git", .branch("master"))

### Usage
Here are some examples of how to use FileSugar:
```swift
// Write to a file
FileModifier.write("~/Desktop/temp.txt".tildePath, "test")

// Check if a file exists
FileAsserter.exists("~/Desktop/temp.txt".tildePath) // Output: true

// Read the contents of a file
FileParser.content("~/Desktop/temp.txt".tildePath) // Output: test
```

### Contributing
If you find a bug or have a feature request, please open an issue on GitHub. Pull requests are also welcome!

### License
FileSugar is available under the MIT license. See the LICENSE file for more info.

### Improvements
- Add test file in spm resource .bundle
- Move FileStreamer into it's own repo again?
- Add more examples to readme?
