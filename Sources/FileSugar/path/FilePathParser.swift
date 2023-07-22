import Foundation

public final class FilePathParser {
   /**
    * - Returns the path to where you can save your app's files. Here it is:
    * - Output: /Users/James/Documents
    */
   public static func appDocPath() -> String? {
      let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
      return paths.first
   }
   /**
    * ## Examples:
    * path("file:///Users/Me/Desktop/Doc.txt")/NSURL obj
    * - Parameter stringPath: - Fixme: ⚠️️ add doc
    */
   public static func path(_ stringPath: String) -> URL? {
      URL(string: stringPath)
   }
   /**
    * ## Examples:
    * path(NSURL("file:///Users/Me/Desktop/Doc.txt"))//Users/Me/Desktop/Doc.txt
    * - Parameter url: - Fixme: ⚠️️ add doc
    */
   public static func path(_ url: URL) -> String {
      url.path
   }
   /**
    * ## Examples:
    * stringPath(path("file:///Users/Me/Desktop/Doc.txt"))//"file:///Users/Me/Desktop/Doc.txt"
    * - Parameter path: - Fixme: ⚠️️ add doc
    */
   public static func stringPath(_ path: URL) -> String {
      path.absoluteString
   }
   /**
    * You can also do: NSString(string: self).stringByExpandingTildeInPath
    */
   public static func userHomePath() -> String {
      NSHomeDirectory()
   }
   /**
    * - Returns: fileName
    * ## Examples:
    * FilePathParser.fileName(fileURL)
    * let filePath = NSString("~/Desktop/temp.xml").expandingTildeInPath
    * let attributes = try! URL(fileURLWithPath:).resourceValuesForKeys([NSURLContentModificationDateKey, NSURLNameKey])
    * let filename = attributes[NSURLNameKey] as! String
    * // you can also do:
    * let fileName = url.lastPathComponent // file.zip etc
    * - Parameters:
    *   - fileURL: - Fixme: ⚠️️ add doc
    *   - withExtension: - Fixme: ⚠️️ add doc
    */
   public static func fileName(_ fileURL: URL, _ withExtension: Bool = true) -> String {
      withExtension ? fileURL.absoluteURL.lastPathComponent : fileURL.absoluteURL.deletingPathExtension().lastPathComponent // was-> absoluteURL.URLByDeletingPathExtension before swift 3 upgrade
   }
   /**
    * ## Examples:
    * fileName("~/Desktop/temp.xml") // temp.xml
    * - Parameters:
    *   - filePath: - Fixme: ⚠️️ add doc
    *   - withExtension: - Fixme: ⚠️️ add doc
    */
   public static func fileName(path filePath: String, withExtension: Bool = true) -> String? {
      guard let url: URL = path(filePath) else { return nil }
      return fileName(url, withExtension)
   }
   /**
    * Returns directory
    * ## Examples:
    * FilePathParser.directory(fileURL)
    * - Parameter fileURL: - Fixme: ⚠️️ add doc
    * - Returns: - Fixme: ⚠️️ add doc
    */
   public static func directory(_ fileURL: URL) -> String {
      fileURL.absoluteURL.deletingPathExtension().absoluteString
   }
   /**
    * Returns the project resource folder
    * - Note: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSBundle_Class/
    * ## Examples:
    * Swift.print(FileParser.content(FilePathParser.resourcePath() + "/temp.bundle/test.txt"))
    */
   public static var resourcePath: String? {
      Bundle.main.resourcePath
   }
   /**
    * Does not need tilde expand to work
    * ## Examples:
    * fileExtension("~/Desktop/temp.xml") // xml
    * - Parameter filePath: - Fixme: ⚠️️ add doc
    */
   public static func fileExtension(_ filePath: String) -> String {
      NSString(string: filePath).pathExtension
   }
}
/**
 * Helper
 */
extension FilePathParser {
   /**
    * Convenience
    * - Parameters:
    *   - fileURL: - Fixme: ⚠️️ add doc
    *   - withExtension: - Fixme: ⚠️️ add doc
    */
   public static func fileName(fileURL: String, _ withExtension: Bool = true) -> String? {
      guard let path = path(fileURL) else { return nil }
      return fileName(path, withExtension)
   }
}
