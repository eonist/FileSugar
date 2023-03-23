[![Tests](https://github.com/eonist/FileSugar/actions/workflows/Tests.yml/badge.svg)](https://github.com/eonist/FileSugar/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/b4b79239-d1f9-4c9a-8c46-d6a1b9dcb559)](https://codebeat.co/projects/github-com-eonist-filesugar-master)

# FileSugar
<img width="100" alt="img" src="https://rawgit.com/stylekit/img/master/FileLib.svg">

### Features:
- Open, Save, Delete, Create (CRUD)

### Installation:
- Swift package manager: `.package(url: "https://github.com/eonist/FileSugar.git", .branch("master"))`

### Examples:
```swift
FileModifier.write("~/Desktop/temp.txt".tildePath, "test")
FileAsserter.exists("~/Desktop/temp.txt".tildePath) // Output: true
FileParser.content("~/Desktop/temp.txt".tildePath) // Output: test
```

### Todo:
- Add test file in spm resource .bundle
