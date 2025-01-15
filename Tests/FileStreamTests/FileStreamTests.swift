import XCTest
@testable import FileSugar
// We use temporary files for testing to avoid affecting any actual files on the filesystem.
// We clean up by removing the temporary files after each test to ensure isolation between tests.
// The use of XCTAssertThrowsError allows us to verify that the correct errors are thrown when expected.
final class FileStreamTests: XCTestCase {

    // Helper property to get a temporary file URL
    var tempFileURL: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
    }

    /// Verifies that data written to a file can be correctly read back.
    func testWriteAndReadData() throws {
        let fileURL = tempFileURL
        let testData = "Hello, FileStream!".data(using: .utf8)!

        // Write data to the file
        try FileStreamWriter.write(url: fileURL, data: testData, index: 0)

        // Read data back from the file
        let readData = try FileStreamReader.read(url: fileURL, startIndex: 0, endIndex: testData.count)

        // Verify that the data read is equal to the data written
        XCTAssertEqual(readData, testData, "Data read should match data written")

        // Clean up
        try? FileManager.default.removeItem(at: fileURL)
    }

    /// Verifies that a specific segment of data can be read from the file.
    func testReadDataWithOffset() throws {
        let fileURL = tempFileURL
        let testString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let testData = testString.data(using: .utf8)!

        // Write data to the file
        try FileStreamWriter.write(url: fileURL, data: testData, index: 0)

        // Read a segment of data from the file
        let startIndex: UInt64 = 5
        let endIndex: Int = 10
        let expectedData = "FGHIJ".data(using: .utf8)!

        let readData = try FileStreamReader.read(url: fileURL, startIndex: startIndex, endIndex: endIndex)

        // Verify that the data read is equal to the expected data
        XCTAssertEqual(readData, expectedData, "Data read should match expected data")

        // Clean up
        try? FileManager.default.removeItem(at: fileURL)
    }

    /// Verifies that attempting to read from a non-existent file throws an error.
    func testReadNonExistentFile() {
        let fileURL = tempFileURL

        // Attempt to read from a non-existent file
        XCTAssertThrowsError(try FileStreamReader.read(url: fileURL, startIndex: 0, endIndex: 10)) { error in
            // Verify that the error is of the expected type
           XCTAssertTrue(((Optional(error) as? NSError) != nil), "Error should be of type NSError")
        }
    }

    /// Checks that the file size returned matches the actual file size.
    func testGetFileSize() throws {
        let filePath = tempFileURL.path
        let testData = "Test File Size".data(using: .utf8)!

        // Write data to the file
        try testData.write(to: URL(fileURLWithPath: filePath))

        // Get the file size
        let fileSize = try FileStreamReader.getFileSize(filePath: filePath)

        // Verify that the file size matches the data length
        XCTAssertEqual(fileSize, UInt64(testData.count), "File size should match data length")

        // Clean up
        try? FileManager.default.removeItem(atPath: filePath)
    }

    /// Tests writing data at the end of an existing file.
    func testAppendData() throws {
        let fileURL = tempFileURL
        let initialData = "Hello, ".data(using: .utf8)!
        let appendData = "World!".data(using: .utf8)!
        let expectedData = "Hello, World!".data(using: .utf8)!

        // Write initial data to the file
        try FileStreamWriter.write(url: fileURL, data: initialData, index: 0)

        // Append data to the file
        let appendIndex = UInt64(initialData.count)
        try FileStreamWriter.write(url: fileURL, data: appendData, index: appendIndex)

        // Read back the entire file data
        let fileSize = try FileStreamReader.getFileSize(filePath: fileURL.path)
        let readData = try FileStreamReader.read(url: fileURL, startIndex: 0, endIndex: Int(fileSize))

        // Verify that the combined data matches the expected data
        XCTAssertEqual(readData, expectedData, "Data after appending should match expected data")

        // Clean up
        try? FileManager.default.removeItem(at: fileURL)
    }

    /// Tests writing data beyond the current end of the file and ensures that the file size is updated accordingly.
    func testWriteBeyondEOF() throws {
        let fileURL = tempFileURL
        let testData = "Test Data".data(using: .utf8)!
        let startIndex: UInt64 = 1000

        // Attempt to write data beyond the current end of file
        try FileStreamWriter.write(url: fileURL, data: testData, index: startIndex)

        // Get the file size
        let fileSize = try FileStreamReader.getFileSize(filePath: fileURL.path)

        // Verify that the file size is startIndex + testData.count
        XCTAssertEqual(fileSize, startIndex + UInt64(testData.count), "File size should reflect the write beyond EOF")

        // Read data back from the file at the start index
        let readData = try FileStreamReader.read(url: fileURL, startIndex: startIndex, endIndex: Int(startIndex) + testData.count)

        // Verify that the data read matches the data written
        XCTAssertEqual(readData, testData, "Data read should match data written at the specified index")

        // Clean up
        try? FileManager.default.removeItem(at: fileURL)
    }

    /// Verifies that the string reading functionality works as expected.
    func testReadString() throws {
        let filePath = tempFileURL.path
        let testString = "Hello, FileStreamReader!"
        try testString.write(toFile: filePath, atomically: true, encoding: .utf8)

        // Read the string using FileStreamReader
        let readString = try FileStreamReader.read(filePath: filePath, start: 0, end: testString.count)

        // Verify that the string read matches the original string
        XCTAssertEqual(readString, testString, "String read should match the original string")

        // Clean up
        try? FileManager.default.removeItem(atPath: filePath)
    }

    /// Verifies that a substring can be read from the file.
     func testPartialReadString() throws {
         let filePath = tempFileURL.path
         let testString = "Hello, FileStreamReader!"
         try testString.write(toFile: filePath, atomically: true, encoding: .utf8)

         // Read a part of the string
         let startIndex: UInt64 = 7
         let endIndex: Int = 17
         let expectedString = "FileStream"

         let readString = try FileStreamReader.read(filePath: filePath, start: startIndex, end: endIndex)

         // Verify that the string read matches the expected substring
         XCTAssertEqual(readString, expectedString, "String read should match the expected substring")

         // Clean up
         try? FileManager.default.removeItem(atPath: filePath)
     }

    /// Tests writing data at a specific index within the file.
    func testWriteAndReadDataAtSpecificIndex() throws {
        let fileURL = tempFileURL
        let initialData = "ABCDEFGH".data(using: .utf8)!
        let newData = "123".data(using: .utf8)!
        let expectedData = "ABC123GH".data(using: .utf8)!

        // Write initial data to the file
        try FileStreamWriter.write(url: fileURL, data: initialData, index: 0)

        // Write new data starting at index 3
        try FileStreamWriter.write(url: fileURL, data: newData, index: 3)

        // Read back the entire file data
        let fileSize = try FileStreamReader.getFileSize(filePath: fileURL.path)
        let readData = try FileStreamReader.read(url: fileURL, startIndex: 0, endIndex: Int(fileSize))

        // Verify that the data in the file matches the expected data
        XCTAssertEqual(readData, expectedData, "Data in the file should match the expected data after writing at specific index")

        // Clean up
        try? FileManager.default.removeItem(at: fileURL)
    }

    /// Verifies that truncating a file works and results in an empty file.
    func testTruncateFile() throws {
        let filePath = tempFileURL.path
        let testData = "Data to be truncated".data(using: .utf8)!

        // Write data to the file
        try FileStreamWriter.write(filePath: filePath, data: testData, index: 0)

        // Truncate the file
        try FileStreamWriter.truncateFile(filePath: filePath)

        // Get the file size
        let fileSize = try FileStreamReader.getFileSize(filePath: filePath)

        // Verify that the file size is now zero
        XCTAssertEqual(fileSize, 0, "File size should be zero after truncation")

        // Clean up
        try? FileManager.default.removeItem(atPath: filePath)
    }

    /// Ensures that attempting to read with an invalid range throws an error.
    func testReadWithInvalidRange() {
        let fileURL = tempFileURL
        let testData = "Test Data".data(using: .utf8)!

        // Write data to the file
        try? FileStreamWriter.write(url: fileURL, data: testData, index: 0)

        // Attempt to read data with invalid range
        let startIndex: UInt64 = 5
        let endIndex: Int = 3 // endIndex less than startIndex

        XCTAssertThrowsError(try FileStreamReader.read(url: fileURL, startIndex: startIndex, endIndex: endIndex)) { error in
            // Verify that the error is of the expected type
            XCTAssertTrue(((Optional(error) as? NSError) != nil), "Error should be of type NSError")
        }
//       XCTAssertThrowsError(try FileStreamReader.read(url: fileURL, startIndex: startIndex, endIndex: endIndex))

        // Clean up
        try? FileManager.default.removeItem(at: fileURL)
    }
} 
