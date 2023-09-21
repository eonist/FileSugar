import Foundation
/**
 * A utility class for writing data to a file at a given path (Continiously)
 */
public final class FileStreamWriter {
   /**
    * Writes data to a file at a given URL
    * ## Examples:
    * let url = URL(fileURLWithPath: "~/Desktop/del.txt")
    * let data = "Hello, world!".data(using: .utf8)!
    * try FileStreamWriter.write(url: url, data: data, index: 0)
    * - Remark: This method writes over the data that is already there (It does not insert)
    * - Note: The link bellow is a Stack Overflow post that discusses how to update a file at a given path using NSFileHandle in Swift, instead of overwriting the entire file. The post includes a code example that demonstrates how to open a file for updating, seek to a specific byte offset, and write data to the file at that offset. The post also includes some additional information about file handling in Swift.
    * - Note:  https://stackoverflow.com/questions/37981375/nsfilehandle-updateatpath-how-can-i-update-file-instead-of-overwriting
    * ## Examples:
    * let filePath:String = NSString(string: "~/Desktop/del.txt").expandingTildeInPath
    * guard let data:Data = ("black dog" as NSString).data(using: String.Encoding.utf8.rawValue) else {Swift.print("unable to create data");return}
    * FileStreamWriter.write(filePath: filePath, data: data, index: 0)
    * - Parameter url: The URL of the file to write to
    * - Parameter data: The data to write to the file
    * - Parameter index: The byte offset to start writing at
    * - Throws: An error if the file cannot be written to
    */
   public static func write(url: URL, data: Data, index: UInt64) throws {
      // Check if the file already exists
      let fileExists: Bool = FileManager().fileExists(atPath: url.path)
      
      if fileExists == false {
         // If the file does not exist, create it and write the data to it
         do {
            try data.write(to: url, options: .atomic)
         } catch {
            // If an error occurs, throw an NSError with a descriptive message
            let str = "⚠️️ FileStreamWriter.write() - Error: \(error.localizedDescription) creating \(url.path)"
            throw NSError(domain: str, code: 0)
         }
      }
      do {
         // Open the file at the given URL for updating
         let file: FileHandle = try .init(forUpdating: url)
         // Seek to the specified byte offset
         file.seek(toFileOffset: index)
         // Write the data to the file
         file.write(data)
         // Close the file
         file.closeFile()
      } catch {
         // If an error occurs, throw an NSError with a descriptive message
         let str = "⚠️️ FileStreamWriter.write() - Error: \(error.localizedDescription) creating \(url.path)"
         throw NSError(domain: str, code: 0)
      }
   }
   /**
    * Truncates a file at a given path
    * ## Examples:
    * let filePath = "~/Desktop/del.txt"
    * try FileStreamWriter.truncateFile(filePath: filePath)
    * - Parameter filePath: The path of the file to truncate
    * - Throws: An error if the file cannot be truncated
    */
   public static func truncateFile(filePath: String) throws {
      // Create a URL from the file path
      let url: URL = .init(fileURLWithPath: filePath)
      do {
         // Open the file at the given URL for updating
         let file: FileHandle = try .init(forUpdating: url)
         // Truncate the file at offset 0
         file.truncateFile(atOffset: 0)
         // Close the file
         file.closeFile()
      } catch {
         // If an error occurs, throw an NSError with a descriptive message
         let str = "⚠️️ Error: \(error) creating \(filePath)"
         throw NSError(domain: str, code: 0)
      }
   }
}
/**
 * Convenience
 */
extension FileStreamWriter {
   /**
    * Writes data to a file at a given path
    * - Fixme: ⚠️️ Use Result type
    * - Parameters:
    *   - filePath: The path of the file to write to
    *   - data: The data to write to the file
    *   - index: The byte offset to start writing at
    * - Throws: An error if the file cannot be written to
    */
   public static func write(filePath: String, data: Data, index: UInt64) throws {
      // Create a URL from the file path
      let url: URL = .init(fileURLWithPath: filePath)
      // Call the write method with the URL
      try write(url: url, data: data, index: index)
   }
}
