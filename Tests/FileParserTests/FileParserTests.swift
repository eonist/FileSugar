import XCTest
@testable import FileSugar

final class FileParserTests: XCTestCase {

    /// Tests reading data from a file URL using `FileParser.data(url:)`.
    func testDataWithURL() throws {
        // Create a temporary file with some data
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent("testDataWithURL.txt")
        let testData = "Test data content".data(using: .utf8)!
        try testData.write(to: fileURL)

        // Use FileParser to read data from the URL
        let data = FileParser.data(url: fileURL)
        XCTAssertNotNil(data, "Data should not be nil")
        XCTAssertEqual(data, testData, "Data read should match data written")

        // Clean up
        try FileManager.default.removeItem(at: fileURL)
    }

    /// Tests reading data from a file path using `FileParser.data(filePath:)`.
    func testDataWithFilePath() throws {
        // Create a temporary file with some data
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent("testDataWithFilePath.txt")
        let testData = "Test data content".data(using: .utf8)!
        try testData.write(to: fileURL)

        // Use FileParser to read data from the file path
        let data = FileParser.data(filePath: fileURL.path)
        XCTAssertNotNil(data, "Data should not be nil")
        XCTAssertEqual(data, testData, "Data read should match data written")

        // Clean up
        try FileManager.default.removeItem(at: fileURL)
    }

    /// Tests reading content from a file path using `FileParser.content(filePath:)`.
    func testContentWithFilePath() throws {
        // Create a temporary file with some content
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent("testContentWithFilePath.txt")
        let testContent = "Test string content"
        try testContent.write(to: fileURL, atomically: true, encoding: .utf8)

        // Use FileParser to read content from the file path
        let content = FileParser.content(filePath: fileURL.path)
        XCTAssertNotNil(content, "Content should not be nil")
        XCTAssertEqual(content, testContent, "Content read should match content written")

        // Clean up
        try FileManager.default.removeItem(at: fileURL)
    }

    /// Tests reading content from a resource file using `FileParser.resourceContent(_:fileExtension:)`.
   /// out of order ⚠️️
//    func testResourceContent() {
//        // This test assumes that a file named "TestResource.txt" exists in the test bundle
//        guard let resourcePath = Bundle.module.path(forResource: "TestResource", ofType: "txt") else {
//            XCTFail("Resource file not found")
//            return
//        }
//
//        // Use FileParser to read content from the resource file
//        let content = FileParser.resourceContent("TestResource", fileExtension: "txt")
//        XCTAssertNotNil(content, "Content should not be nil")
//
//        // Verify that the content matches the expected value
//        let expectedContent = try? String(contentsOfFile: resourcePath, encoding: .utf8)
//        XCTAssertEqual(content, expectedContent, "Content read should match resource content")
//    }

    /// Tests retrieving the modification date of a file using `FileParser.modificationDate(_:)`.
    func testModificationDate() throws {
        // Create a temporary file
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent("testModificationDate.txt")
        let testContent = "Test content"
        try testContent.write(to: fileURL, atomically: true, encoding: .utf8)

        // Get the modification date using FileParser
        guard let modificationDate = FileParser.modificationDate(fileURL.path) else {
            XCTFail("Failed to get modification date")
            return
        }

        // Get the modification date using FileManager for comparison
        let attributes = try FileManager.default.attributesOfItem(atPath: fileURL.path)
        let expectedDate = attributes[.modificationDate] as? Date

        XCTAssertEqual(modificationDate as Date?, expectedDate, "Modification dates should match")

        // Clean up
        try FileManager.default.removeItem(at: fileURL)
    }

    /// Tests retrieving the contents of a directory using `FileParser.content(dirPath:)`.
    func testContentWithDirPath() throws {
        // Create a temporary directory with some files
        let tempDir = FileManager.default.temporaryDirectory.appendingPathComponent("testContentDir", isDirectory: true)
        try FileManager.default.createDirectory(at: tempDir, withIntermediateDirectories: true)

        // Create some files in the directory
        let fileNames = ["File1.txt", "File2.txt", "File3.txt"]
        for fileName in fileNames {
            let fileURL = tempDir.appendingPathComponent(fileName)
            try "Content of \(fileName)".write(to: fileURL, atomically: true, encoding: .utf8)
        }

        // Use FileParser to get the content of the directory
        let contents = FileParser.content(dirPath: tempDir.path)
        XCTAssertNotNil(contents, "Directory contents should not be nil")
        XCTAssertEqual(contents?.sorted(), fileNames.sorted(), "Directory contents should match the expected file names")

        // Clean up
        try FileManager.default.removeItem(at: tempDir)
    }

    /// Tests retrieving the temporary directory path using `FileParser.tempPath`.
    func testTempPath() {
        let tempPath = FileParser.tempPath
        XCTAssertFalse(tempPath.isEmpty, "Temp path should not be empty")
        XCTAssertTrue(FileManager.default.fileExists(atPath: tempPath), "Temp path should exist")
    }

    /// Tests retrieving the current directory path using `FileParser.curDir`.
    func testCurDir() {
        let curDir = FileParser.curDir
        XCTAssertFalse(curDir.isEmpty, "Current directory path should not be empty")
        // Here we can compare curDir to FileManager.default.currentDirectoryPath
        XCTAssertEqual(curDir, FileManager.default.currentDirectoryPath, "Current directory paths should match")
    }

    #if os(macOS)
    /// Tests parsing an XML file using `FileParser.xml(_:)`. This test is only executed on macOS.
    func testXMLParsing() throws {
        // Create a temporary XML file
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent("testXMLParsing.xml")
        let xmlContent = """
        <?xml version="1.0" encoding="UTF-8"?>
        <note>
            <to>User</to>
            <from>Assistant</from>
            <message>Hello, this is a test.</message>
        </note>
        """
        try xmlContent.write(to: fileURL, atomically: true, encoding: .utf8)

        // Use FileParser to parse the XML file
        guard let rootElement = FileParser.xml(fileURL.path) else {
            XCTFail("Failed to parse XML")
            return
        }

        XCTAssertEqual(rootElement.name, "note", "Root element should be 'note'")

        // Clean up
        try FileManager.default.removeItem(at: fileURL)
    }
    #endif

    /// Tests reading content asynchronously from a file using `FileParser.readContentAsync(url:)`.
    func testReadContentAsync() async throws {
        // Create a temporary file with some content
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent("testReadContentAsync.txt")
        let testContent = "Hello, Async World!"
        try testContent.write(to: fileURL, atomically: true, encoding: .utf8)

        do {
            let content = try await FileParser.readContentAsync(url: fileURL)
            XCTAssertEqual(content, testContent, "Content should match the test content")
        } catch {
            XCTFail("Failed to read content asynchronously: \(error)")
        }

        // Clean up
        try FileManager.default.removeItem(at: fileURL)
    }

    /// Tests reading data asynchronously from a file using `FileParser.readDataAsync(url:)`.
    func testReadDataAsync() async throws {
        // Create a temporary file with some data
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent("testReadDataAsync.txt")
        let testData = "Hello, Async Data!".data(using: .utf8)!
        try testData.write(to: fileURL)

        do {
            let data = try await FileParser.readDataAsync(url: fileURL)
            XCTAssertEqual(data, testData, "Data should match the test data")
        } catch {
            XCTFail("Failed to read data asynchronously: \(error)")
        }

        // Clean up
        try FileManager.default.removeItem(at: fileURL)
    }
} 
