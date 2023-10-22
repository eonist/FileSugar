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
        let paths: [String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) // Get an array of paths to the user's document directory
        return paths.first // Return the first path in the array (which should be the document directory)
    }
    /**
     * Parses a string path into a URL object
     * - Parameter stringPath: The string path to parse
     * - Returns: The URL object, or nil if the path cannot be parsed
     * ## Example:
     * let url = FilePathParser.path("file:///Users/Me/Desktop/Doc.txt") // NSURL object
     */
    public static func path(_ stringPath: String) -> URL? {
        URL(string: stringPath) // Create a URL from the given string path
    }
    /**
     * Converts a URL object to a string path
     * - Parameter url: The URL object to convert
     * - Returns: The string path, or an empty string if the URL cannot be converted
     * ## Example:
     * let path = FilePathParser.path(NSURL("file:///Users/Me/Desktop/Doc.txt")) // "/Users/Me/Desktop/Doc.txt"
     */
    public static func path(_ url: URL) -> String {
        url.path // Get the path component of the URL as a string
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
        NSHomeDirectory() // Get the path to the user's home directory
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
        // If withExtension is true, return the last path component of the URL (including the file extension)
        // Otherwise, return the last path component of the URL without the file extension
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
        guard let url: URL = path(filePath) else { return nil } // Get the URL from the file path
        return fileName(url, withExtension) // Get the file name from the URL and return it
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
        fileURL.absoluteURL // Get the absolute URL of the file URL
            .deletingPathExtension() // Delete the file extension from the URL
            .absoluteString // Convert the URL back to a string
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
        Bundle.main.resourcePath // Get the path to the main bundle's resource directory
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
        NSString(string: filePath).pathExtension // Get the file extension from the file path as an NSString
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
    guard let path: URL = path(fileURL) else { return nil } // Get the path from the file URL
    return fileName(path, withExtension) // Get the file name from the path and return it
   }
}
