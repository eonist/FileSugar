import Foundation
/**
 * Reads data from a file (Continiously)
 */
public final class FileStreamReader {
   /**
    * Reads data from filepath
    * ## Examples:
    * let filePath: String = NSString(string: "~/Desktop/del.txt").expandingTildeInPath
    * let data:Data = FileStreamReader.read(filePath: filePath, startIndex: 50, endIndex: 100)
    * Swift.print("\(String(data: data, encoding: .utf8))") // blalbslalballabalbla...
    * Fixme: ⚠️️ Use UInt64 on endIndex
    * Fixme: ⚠️️ Use Result type
    */
   public static func read(url: URL, startIndex: UInt64, endIndex: Int) throws -> Data {
      do {
         let file: FileHandle = try .init(forReadingFrom: url)
         file.seek(toFileOffset: startIndex)
         let length: Int = endIndex - Int(startIndex)
         let databuffer = file.readData(ofLength: length)
         file.closeFile()
         return databuffer
      } catch {
         throw NSError(domain: ("Error: \(error) reading \(url.path)"), code: 0)
      }
   }
}
extension FileStreamReader {
   /**
    * Returns filesize for a filePath
    * ## Examples:
    * let fileSize = FileStreamReader.fileSize(filePath: filePath)
    * - Note: same as doing `data.count`
    */
   public static func fileSize(filePath: String) throws -> UInt64 {
      let fileUrl = URL(fileURLWithPath: filePath)
      let fileManager = FileManager.default
      do {
         let attributes = try fileManager.attributesOfItem(atPath: (fileUrl.path))
         var fileSize = attributes[FileAttributeKey.size] as! UInt64
         let dict = attributes as NSDictionary
         fileSize = dict.fileSize()
         return fileSize
      }
      catch let error as NSError {
         throw NSError(domain: ("⚠️️ Something went wrong: \(error)"), code: 0)
      }
   }
}
extension FileStreamReader {
   /**
    * Support for filePath
    */
   public static func read(filePath: String, startIndex: UInt64, endIndex: Int) throws -> Data {
      let url: URL = .init(fileURLWithPath: filePath)
      return try read(url: url, startIndex: startIndex, endIndex: endIndex)
   }
   /**
    * Read string
    */
   static func read(filePath: String, start: UInt64, end: Int) throws -> String {
      let data: Data = try FileStreamReader.read(filePath: filePath, startIndex: start, endIndex: end)
      guard let string = String(data: data, encoding: .utf8) else { throw NSError(domain: "FileStreamReader.read() - Unable to get string from data data.count: \(data.count)", code: 0) }
      return string
   }
}
