import XCTest
@testable import FileSugar

final class FileModifierTests: XCTestCase {
    // fixme add doc
    func testWriteFile() {
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("test.txt")
        let data = "Hello, Swift!".data(using: .utf8)!
        do {
            try data.write(to: fileURL, options: [.atomic])
            XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL.path))
            let content = try String(contentsOf: fileURL, encoding: .utf8)
            XCTAssertEqual(content, "Hello, Swift!")
        } catch {
            XCTFail("Failed with error: \(error.localizedDescription)")
        }
    }
}
