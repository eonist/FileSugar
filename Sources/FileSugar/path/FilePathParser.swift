import Foundation
/**
 * A utility class for working with file paths and URLs
 */
public final class FilePathParser {
   /**
     * Returns the path to the app's documents directory
     * - Returns: The path to the app's documents directory, or nil if it cannot be determined
     * ## Example:
     * let appDocPath = FilePathParser.appDocPath() // "/Users/James/Documents"
     */
    public static func appDocPath() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths.first
    }
    
    /**
     * Parses a string path into a URL object
     * - Parameter stringPath: The string path to parse
     * - Returns: The URL object, or nil if the path cannot be parsed
     * ## Example:
     * let url = FilePathParser.path("file:///Users/Me/Desktop/Doc.txt") // NSURL object
     */
    public static func path(_ stringPath: String) -> URL? {
        URL(string: stringPath)
    }
    
    /**
     * Converts a URL object to a string path
     * - Parameter url: The URL object to convert
     * - Returns: The string path, or an empty string if the URL cannot be converted
     * ## Example:
     * let path = FilePathParser.path(NSURL("file:///Users/Me/Desktop/Doc.txt")) // "/Users/Me/Desktop/Doc.txt"
     */
    public static func path(_ url: URL) -> String {
        url.path
    }
    
    /**
     * Converts a URL object to a string path
     * - Parameter path: The URL object to convert
     * - Returns: The string path, or an empty string if the URL cannot be converted
     * ## Example:
     * let stringPath = FilePathParser.stringPath(FilePathParser.path("file:///Users/Me/Desktop/Doc.txt")) // "file:///Users/Me/Desktop/Doc.txt"
     */
    public static func stringPath(_ path: URL) -> String {
        path.absoluteString
    }
   /**
     * Returns the path to the user's home directory.
     */
    public static func userHomePath() -> String {
        NSHomeDirectory()
    }
    
    /**
     * Returns the file name of the given URL.
     *
     * - Parameters:
     *   - fileURL: The URL of the file.
     *   - withExtension: Whether to include the file extension in the returned name. Defaults to `true`.
     * - Returns: The file name.
     *
     * Example usage:
     * ```
     * let fileURL = URL(fileURLWithPath: "~/Desktop/temp.xml")
     * let fileName = FilePathParser.fileName(fileURL)
     * ```
     */
    public static func fileName(_ fileURL: URL, _ withExtension: Bool = true) -> String {
        withExtension ? fileURL.absoluteURL.lastPathComponent : fileURL.absoluteURL.deletingPathExtension().lastPathComponent
    }
    
    /**
     * Returns the file name of the file at the given path.
     *
     * - Parameters:
     *   - filePath: The path of the file.
     *   - withExtension: Whether to include the file extension in the returned name. Defaults to `true`.
     * - Returns: The file name, or `nil` if the file does not exist.
     *
     * Example usage:
     * ```
     * let fileName = FilePathParser.fileName(path: "~/Desktop/temp.xml")
     * ```
     */
    public static func fileName(path filePath: String, withExtension: Bool = true) -> String? {
        guard let url: URL = path(filePath) else { return nil }
        return fileName(url, withExtension)
    }
    
    /**
     * Returns the directory of the given file URL.
     *
     * - Parameter fileURL: The URL of the file.
     * - Returns: The directory.
     *
     * Example usage:
     * ```
     * let fileURL = URL(fileURLWithPath: "~/Desktop/temp.xml")
     * let directory = FilePathParser.directory(fileURL)
     * ```
     */
    public static func directory(_ fileURL: URL) -> String {
        fileURL.absoluteURL.deletingPathExtension().absoluteString
    }
    
    /**
     * Returns the path to the project's resource folder.
     *
     * Example usage:
     * ```
     * let content = FileParser.content(FilePathParser.resourcePath() + "/temp.bundle/test.txt")
     * ```
     */
    public static var resourcePath: String? {
        Bundle.main.resourcePath
    }
    
    /**
     * Returns the file extension of the file at the given path.
     *
     * - Parameter filePath: The path of the file.
     * - Returns: The file extension.
     *
     * Example usage:
     * ```
     * let fileExtension = FilePathParser.fileExtension("~/Desktop/temp.xml")
     * ```
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
    * Returns the file name from a given file URL.
    * 
    * - Parameters:
    *    - fileURL: The file URL to extract the file name from.
    *    - withExtension: Whether or not to include the file extension in the returned file name. Defaults to `true`.
    * 
    * - Returns: The file name from the given file URL, or `nil` if the file URL is invalid.
    * Example usage:
    * let fileURL = "file:///Users/username/Documents/example.txt" let fileName = FilePathParser.fileName(fileURL: fileURL) // fileName == "example.txt"
    */
   public static func fileName(fileURL: String, _ withExtension: Bool = true) -> String? {
      guard let path = path(fileURL) else { return nil }
      return fileName(path, withExtension)
   }
}
