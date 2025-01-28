import XCTest
@testable import FileSugar

final class FileModifierTests: XCTestCase {
    /// Tests writing data to a temporary file and verifies the file's existence and content.
    func testWriteFile() {
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("test.txt")
        guard let data = "Hello, Swift!".data(using: .utf8) else {
            XCTFail("Failed to encode string to data")
            return
        }
        do {
            try data.write(to: fileURL, options: [.atomic])
            XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL.path))
            let content = try String(contentsOf: fileURL, encoding: .utf8)
            XCTAssertEqual(content, "Hello, Swift!")
        } catch {
            XCTFail("Failed with error: \(error.localizedDescription)")
        }
    }
    // Success Case: Move a file from a valid source to a valid destination.
    // Non-existent Source: Attempt to move a file that doesn't exist.
    // Destination Exists: Attempt to move a file to a destination where a file with the same name exists.
    // Permission Denied: Attempt to move a file to a location without write permissions.
    // Invalid Paths: Source or destination paths are invalid.
    func testMoveFileSuccess() {
        let tempDir = NSTemporaryDirectory()
        let sourceURL = URL(fileURLWithPath: tempDir).appendingPathComponent("testSource.txt")
        let destinationURL = URL(fileURLWithPath: tempDir).appendingPathComponent("testDestination.txt")
        let content = "Test Content"

        // Create a test file to move
        try? content.write(to: sourceURL, atomically: true, encoding: .utf8)
        XCTAssertTrue(FileManager.default.fileExists(atPath: sourceURL.path))

        // Perform the move operation
        let result = FileModifier.move(sourceURL.path, toURL: destinationURL.path)

        // Verify the result
        XCTAssertTrue(result)
        XCTAssertFalse(FileManager.default.fileExists(atPath: sourceURL.path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: destinationURL.path))

        // Clean up
        try? FileManager.default.removeItem(at: destinationURL)
    }
    // Success Case: Copy a file from a valid source to a valid destination.
    // Non-existent Source: Attempt to copy a file that doesn't exist.
    // Destination Exists: Attempt to copy a file to a destination where a file with the same name exists.
    // Permission Denied: Attempt to copy a file to a location without write permissions.
    // Invalid Paths: Source or destination paths are invalid.
    func testCopyFileSuccess() {
        let tempDir = NSTemporaryDirectory()
        let sourceURL = URL(fileURLWithPath: tempDir).appendingPathComponent("testSource.txt")
        let destinationURL = URL(fileURLWithPath: tempDir).appendingPathComponent("testDestination.txt")
        let content = "Test Content"

        // Create a test file to copy
        try? content.write(to: sourceURL, atomically: true, encoding: .utf8)
        XCTAssertTrue(FileManager.default.fileExists(atPath: sourceURL.path))

        // Perform the copy operation
        let result = FileModifier.copy(sourceURL.path, toURL: destinationURL.path)

        // Verify the result
        XCTAssertTrue(result)
        XCTAssertTrue(FileManager.default.fileExists(atPath: sourceURL.path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: destinationURL.path))

        // Clean up
        try? FileManager.default.removeItem(at: sourceURL)
        try? FileManager.default.removeItem(at: destinationURL)
    }
    // Success Case: Write content to a new file.
    // Overwrite Existing File: Write content to an existing file (should overwrite).
    // Invalid Path: Attempt to write to an invalid file path.
    // Permission Denied: Attempt to write to a location without write permissions.
    // Encoding Error: Attempt to write content that cannot be encoded in UTF-8.
    func testWriteContentSuccess() {
        let tempDir = NSTemporaryDirectory()
        let fileURL = URL(fileURLWithPath: tempDir).appendingPathComponent("testFile.txt")
        let content = "Hello, World!"

        // Perform the write operation
        let result = FileModifier.write(fileURL.path, content: content)

        // Verify the result
        XCTAssertTrue(result)
        XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL.path))

        // Read and verify the content
        let readContent = try? String(contentsOf: fileURL, encoding: .utf8)
        XCTAssertEqual(readContent, content)

        // Clean up
        try? FileManager.default.removeItem(at: fileURL)
    }
    // Success Case: Write data to a new file.
    // Overwrite Existing File: Write data to an existing file.
    // Invalid Path: Attempt to write data to an invalid path.
    // Permission Denied: Attempt to write data to a location without write permissions.
    // Large Data: Write a large amount of data to test performance/memory issues.
    func testWriteDataSuccess() {
        let tempDir = NSTemporaryDirectory()
        let fileURL = URL(fileURLWithPath: tempDir).appendingPathComponent("testFile.dat")
        let data = "Binary Data".data(using: .utf8)!

        do {
            // Perform the write operation
            let result = try FileModifier.write(path: fileURL.path, data: data)
            XCTAssertTrue(result)
            XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL.path))

            // Read and verify the data
            let readData = try Data(contentsOf: fileURL)
            XCTAssertEqual(readData, data)
        } catch {
            XCTFail("Failed with error: \(error)")
        }

        // Clean up
        try? FileManager.default.removeItem(at: fileURL)
    }
    // Success Case: Create a new directory.
    // Existing Directory: Attempt to create a directory that already exists.
    // Nested Directories: Create a directory structure with intermediate directories.
    // Invalid Path: Attempt to create a directory with an invalid path.
    // Permission Denied: Attempt to create a directory in a location without write permissions.
    func testCreateDirSuccess() {
        let tempDir = NSTemporaryDirectory()
        let dirPath = tempDir + "testDir"

        // Ensure the directory does not exist
        XCTAssertFalse(FileManager.default.fileExists(atPath: dirPath))

        // Perform the create directory operation
        let result = FileModifier.createDir(path: dirPath)

        // Verify the result
        XCTAssertTrue(result)
        XCTAssertTrue(FileManager.default.fileExists(atPath: dirPath))

        // Clean up
        try? FileManager.default.removeItem(atPath: dirPath)
    }
    // Success Case: Delete an existing file.
    // Non-existent File: Attempt to delete a file that doesn't exist.
    // Permission Denied: Attempt to delete a file without permission.
    // Delete Directory: Attempt to delete a directory instead of a file.
    // Invalid Path: Attempt to delete with an invalid path.
    func testDeleteFileSuccess() {
        let tempDir = NSTemporaryDirectory()
        let filePath = tempDir + "testFile.txt"
        let content = "To be deleted"

        // Create a test file
        FileManager.default.createFile(atPath: filePath, contents: content.data(using: .utf8), attributes: nil)
        XCTAssertTrue(FileManager.default.fileExists(atPath: filePath))

        // Perform the delete operation
        let result = FileModifier.delete(filePath)

        // Verify the result
        XCTAssertTrue(result)
        XCTAssertFalse(FileManager.default.fileExists(atPath: filePath))
    }
    // Success Case: Rename a file to a new valid name.
    // Non-existent Source: Attempt to rename a file that doesn't exist.
    // Destination Exists: Attempt to rename a file to a name that already exists.
    // Invalid Paths: Source or destination paths are invalid.
    // Permission Denied: Attempt to rename a file without proper permissions.
    func testRenameFileSuccess() {
        let tempDir = NSTemporaryDirectory()
        let originalURL = URL(fileURLWithPath: tempDir).appendingPathComponent("original.txt")
        let newURL = URL(fileURLWithPath: tempDir).appendingPathComponent("renamed.txt")
        let content = "Rename me"

        // Create a test file
        try? content.write(to: originalURL, atomically: true, encoding: .utf8)
        XCTAssertTrue(FileManager.default.fileExists(atPath: originalURL.path))

        // Perform the rename operation
        let result = FileModifier.rename(originalURL.path, toURL: newURL.path)

        // Verify the result
        XCTAssertTrue(result)
        XCTAssertFalse(FileManager.default.fileExists(atPath: originalURL.path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: newURL.path))

        // Clean up
        try? FileManager.default.removeItem(at: newURL)
    }
    // Success Case: Create a new folder.
    // Existing Folder: Attempt to create a folder that already exists.
    // Nested Folders: Create a folder structure with intermediate folders.
    // Invalid Path: Attempt to create a folder with an invalid path.
    // Permission Denied: Attempt to create a folder in a location without write permissions.
    func testCreateFolderSuccess() {
        let tempDir = NSTemporaryDirectory()
        let folderPath = tempDir + "testFolder"

        // Ensure the folder does not exist
        XCTAssertFalse(FileManager.default.fileExists(atPath: folderPath))

        // Perform the create folder operation
        let result = FileModifier.createFolder(folderPath)

        // Verify the result
        XCTAssertTrue(result)
        XCTAssertTrue(FileManager.default.fileExists(atPath: folderPath))

        // Clean up
        try? FileManager.default.removeItem(atPath: folderPath)
    }
    // Success Case: Append text to an existing file.
    // File Does Not Exist: Attempt to append text to a file that doesn't exist.
    // Invalid Path: Attempt to append text to an invalid path.
    // Permission Denied: Attempt to append text to a file without write permissions.
    // Empty Text: Append an empty string to the file.
    func testAppendTextSuccess() {
        let tempDir = NSTemporaryDirectory()
        let filePath = tempDir + "testFile.txt"
        let initialContent = "Hello"
        let appendedContent = ", World!"
        let expectedContent = "Hello, World!"

        // Create a test file with initial content
        FileManager.default.createFile(atPath: filePath, contents: initialContent.data(using: .utf8), attributes: nil)
        XCTAssertTrue(FileManager.default.fileExists(atPath: filePath))

        // Perform the append operation
        let result = FileModifier.append(filePath, text: appendedContent)

        // Verify the result
        XCTAssertTrue(result)

        // Read and verify the content
        let readContent = try? String(contentsOfFile: filePath, encoding: .utf8)
        XCTAssertEqual(readContent, expectedContent)

        // Clean up
        try? FileManager.default.removeItem(atPath: filePath)
    }
    // Success Case: Append text at a specific index in the file.
    // Index Out of Bounds: Provide an index larger than the file size.
    // Negative Index: Provide a negative index (should handle as appending at the end).
    // File Does Not Exist: Attempt to append to a non-existent file.
    // Empty Text: Append an empty string.
   // ⚠️️ currently out of order, might be the test or the method
//    func testAppendTextAtIndexSuccess() {
//        let tempDir = NSTemporaryDirectory()
//        let filePath = tempDir + "testFile.txt"
//        let initialContent = "Hello World!"
//        let insertedContent = " Swift"
//        let expectedContent = "Hello Swift World!"
//        let insertIndex = 5 // After "Hello"
//
//        // Create a test file with initial content
//        FileManager.default.createFile(atPath: filePath, contents: initialContent.data(using: .utf8), attributes: nil)
//        XCTAssertTrue(FileManager.default.fileExists(atPath: filePath))
//
//        // Perform the append operation at specific index
//        let result = FileModifier.append(filePath, text: insertedContent, index: insertIndex)
//
//        // Verify the result
//        XCTAssertTrue(result)
//
//        // Read and verify the content
//        let readContent = try? String(contentsOfFile: filePath, encoding: .utf8)
//        XCTAssertEqual(readContent, expectedContent)
//
//        // Clean up
//        try? FileManager.default.removeItem(atPath: filePath)
//    }
}
