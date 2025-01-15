import XCTest
@testable import FileSugar

final class FileSugarTests: XCTestCase {
   override func setUp() {
      super.setUp()
      // Put setup code here. This method is called before the invocation of each test method in the class.
   }
   // Async Test Method: The test method is marked with async throws, allowing the use of await and proper error handling.
   // File URL: It uses the same fileURL as in your code, ensuring consistency.
   func testFileParserAsyncContent() async throws {
      let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("temp.txt")
      let testContent = "Hello, World!"
      try testContent.write(to: fileURL, atomically: true, encoding: .utf8)
      
      do {
         let content = try await FileParser.readContentAsync(url: fileURL)
         XCTAssertEqual(content, testContent, "Content should match the test content")
      } catch {
         XCTFail("Failed to read file: \(error.localizedDescription)")
      }
      
      // Clean up
      try? FileManager.default.removeItem(at: fileURL)
   }
   // If you need to support earlier versions of Swift or prefer not to use async test methods, you can use expectations:
   // fixme: add doc
   func testFileParserAsyncContentOlderSwift() throws {
      let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("temp.txt")
      let testContent = "Hello, World!"
      try testContent.write(to: fileURL, atomically: true, encoding: .utf8)
      
      let expectation = self.expectation(description: "File content should be read")
      
      Task {
         do {
            let content = try await FileParser.readContentAsync(url: fileURL)
            XCTAssertNotNil(content, "Content should not be nil")
            expectation.fulfill()
         } catch {
            XCTFail("Failed to read file: \(error.localizedDescription)")
            expectation.fulfill()
         }
      }
      
      waitForExpectations(timeout: 5, handler: nil)
      
      // Clean up
      try? FileManager.default.removeItem(at: fileURL)
   }
   // fixme: add doc
   func testWriteContentAsync() async throws {
      let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("temp.txt")
      let testContent = "Hello, World!"
      try await FileModifier.writeContentAsync(url: fileURL, content: testContent)
      let content = try await FileParser.readContentAsync(url: fileURL)
      XCTAssertEqual(content, testContent, "Content should match the test content")
   }
   // fixme: add doc
   func testWriteDataAsync() async throws {
      let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("temp.txt")
      let testData = "Hello, World!".data(using: .utf8)!
      try await FileModifier.writeDataAsync(url: fileURL, data: testData)
      let data = try await FileParser.readDataAsync(url: fileURL)
      XCTAssertEqual(data, testData, "Data should match the test data")
   }
}
