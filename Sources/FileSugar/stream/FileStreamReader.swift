import Foundation
/**
 * Reads data from a file (Continiously)
 * - Description: Provides functionality to continuously read data from a file stream.
 */
public final class FileStreamReader {
   /**
    * Reads data from a file at a given URL
    * Reads data from a specified range in a file and returns it as Data.
    * ## Examples:
    * let url = URL(fileURLWithPath: "~/Desktop/del.txt")
    * let data = try FileStreamReader.read(url: url, startIndex: 50, endIndex: 100)
    * Swift.print("\(String(data: data, encoding: .utf8))") // blalbslalballabalbla...
    * - Parameter url: The URL of the file to read
    * - Parameter startIndex: The starting byte offset to read from
    * - Parameter endIndex: The ending byte offset to read to
    * - Throws: An error if the file cannot be read
    * - Returns: The data read from the file
    * Fixme: ⚠️️ Use UInt64 on endIndex
    * Fixme: ⚠️️ Use Result type
    */
   public static func read(url: URL, startIndex: UInt64, endIndex: Int) throws -> Data {
      do {
         let file: FileHandle = try .init(forReadingFrom: url) // Open the file at the given URL for reading
         file.seek(toFileOffset: startIndex) // Seek to the starting byte offset
         let length: Int = endIndex - Int(startIndex) // Calculate the length of the data to read
         let databuffer: Data = file.readData(ofLength: length) // Read the data from the file
         file.closeFile() // Close the file
         return databuffer // Return the data read from the file
      } catch {
         // If an error occurs, throw an NSError with a descriptive message
         throw NSError(domain: ("Error: \(error) reading \(url.path)"), code: 0)
      }
   }
}
// getter
extension FileStreamReader {
   /**
    * Returns the size of a file at a given path
    * - Description: Retrieves the size of the file at the specified path in bytes.
    * ## Examples:
    * let filePath = "~/Desktop/del.txt"
    * let fileSize = try FileHelper.getFileSize(filePath: filePath)
    * Swift.print("\(fileSize)") // 12345
    * - Parameter filePath: The path of the file to get the size of
    * - Throws: An error if the file size cannot be determined
    * - Returns: The size of the file in bytes
    */
   public static func getFileSize(filePath: String) throws -> UInt64 {
      // Create a URL from the file path
      let fileUrl = URL(fileURLWithPath: filePath)
      // Get the default file manager
      let fileManager = FileManager.default
      do {
         // Get the attributes of the file at the URL
         let attributes: [FileAttributeKey: Any] = try fileManager.attributesOfItem(atPath: (fileUrl.path))
         // Get the file size from the attributes dictionary
         var fileSize: UInt64 = attributes[FileAttributeKey.size] as! UInt64
         // Alternatively, get the file size from the attributes dictionary using the fileSize() method
         let dict: NSDictionary = attributes as NSDictionary
         fileSize = dict.fileSize()
         // Return the file size
         return fileSize
      } catch let error as NSError {
         // If an error occurs, throw an NSError with a descriptive message
         throw NSError(domain: ("⚠️️ Something went wrong: \(error)"), code: 0)
      }
   }
}
// reader
extension FileStreamReader {
   /**
    * Support for filePath
    * - Description: Reads a segment of data from a file at a specified path, starting and ending at the given byte indices.
    */
   public static func read(filePath: String, startIndex: UInt64, endIndex: Int) throws -> Data {
      // Create a URL from the file path
      let url: URL = .init(fileURLWithPath: filePath)
      // Call the read method with the URL
      return try read(url: url, startIndex: startIndex, endIndex: endIndex)
   }
   /**
    * Read string
    * - Description: Reads a segment of data from a file at a specified path, starting and ending at the given byte indices, and converts it to a string using UTF-8 encoding.
    */
   internal static func read(filePath: String, start: UInt64, end: Int) throws -> String {
      // Read the data from the file at the given path
      let data: Data = try FileStreamReader.read(filePath: filePath, startIndex: start, endIndex: end)
      // Convert the data to a string using UTF-8 encoding
      guard let string: String = .init(data: data, encoding: .utf8) else {
         // If the data cannot be converted to a string, throw an NSError with a descriptive message
         throw NSError(domain: "FileStreamReader.read() - Unable to get string from data data.count: \(data.count)", code: 0)
      }
      // Return the string
      return string
   }
}
