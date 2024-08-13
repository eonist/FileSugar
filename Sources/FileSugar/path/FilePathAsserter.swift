import Foundation

public final class FilePathAsserter {
    /**
     * Tests if a path is absolute or relative
     * - Description: Determines if the provided path is absolute based on the specified path separator.
     * ## Example:
     * let path = "/Users/username/Documents"
     * let isAbsolutePath = FilePathAsserter.isAbsolute(path) // true
     * - Parameters:
     *   - path: The path to test
     *   - pathSeperator: The path separator to use (default is "/")
     * - Returns: True if the path is absolute, false if it is relative
     */
    public static func isAbsolute(_ path: String, pathSeperator: String = "/") -> Bool {
         path.hasPrefix(pathSeperator) // Check if the path starts with the path separator
    }
    /**
     * Tests if a path contains a relative path (i.e. "../")
     * - Description: Determines if the provided path contains a relative path segment such as "../", which indicates a step back in the directory hierarchy.
     * ## Example:
     * let path = "../User/Documents/example.txt"
     * let containsBacklash = FilePathAsserter.isBacklash(path) // true
     * - Parameter path: The path to test
     * - Returns: True if the path contains a relative path, false otherwise
     */
    public static func isBacklash(_ path: String) -> Bool {
         path.hasPrefix("../") // Check if the path starts with "../"
    }
    /**
     * Tests if a path is a file path (i.e. starts with a path separator or "../")
     * - Description: Determines if the provided path is a file path by checking if it starts with a path separator or a relative path prefix.
     * ## Example:
     * let path = "/Users/username/Documents/example.txt"
     * let isFilePath = FilePathAsserter.isFilePath(path) // true
     * - Parameters:
     *   - path: The path to test
     *   - pathSeperator: The path separator to use (default is "/")
     * - Returns: True if the path is a file path, false otherwise
     */
    public static func isFilePath(_ path: String, pathSeperator: String = "/") -> Bool {
        // Check if the path starts with the path separator or "../"
         path.hasPrefix(pathSeperator) || path.hasPrefix(".." + pathSeperator)
    }
    /**
     * Tests if a path is a tilde path (i.e. starts with "~")
     * - Description: Determines if the provided path starts with a tilde ("~"), which typically represents the home directory in Unix-like systems.
     * ## Example:
     * let path = "~/Documents/example.txt"
     * let isTildePath = FilePathAsserter.isTildePath(path) // true
     * - Parameter path: The path to test
     * - Returns: True if the path is a tilde path, false otherwise
     */
    public static func isTildePath(_ path: String) -> Bool {
         path.hasPrefix("~") // Check if the path starts with "~"
    }
}
