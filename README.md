# FileSugar

<img width="100" alt="img" src="https://rawgit.com/stylekit/img/master/FileLib.svg">

### Features:
- Open, Save, Delete, Create (CRUD)

### Installation:
- SPM: `.package(url: "https://github.com/eonist/FileSugar.git", .branch("master"))`

### Examples:
```swift
FileModifier.write("~/Desktop/temp.txt".tildePath, "test")
FileAsserter.exists("~/Desktop/temp.txt".tildePath) // Output: true
FileParser.content("~/Desktop/temp.txt".tildePath) // Output: test
```
