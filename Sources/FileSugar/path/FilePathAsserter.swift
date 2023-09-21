import Foundation

public final class FilePathAsserter {
    /**
     * Tests if a path is absolute or relative
     * - Parameter path: The path to test
     * - Parameter pathSeperator: The path separator to use (default is "/")
     * - Returns: True if the path is absolute, false if it is relative
     */
    public static func isAbsolute(_ path: String, pathSeperator: String = "/") -> Bool {
        // Check if the path starts with the path separator
        return path.hasPrefix(pathSeperator)
    }
    
    /**
     * Tests if a path contains a relative path (i.e. "../")
     * - Parameter path: The path to test
     * - Returns: True if the path contains a relative path, false otherwise
     */
    public static func isBacklash(_ path: String) -> Bool {
        // Check if the path starts with "../"
        return path.hasPrefix("../")
    }
    
    /**
     * Tests if a path is a file path (i.e. starts with a path separator or "../")
     * - Parameter path: The path to test
     * - Parameter pathSeperator: The path separator to use (default is "/")
     * - Returns: True if the path is a file path, false otherwise
     */
    public static func isFilePath(_ path: String, pathSeperator: String = "/") -> Bool {
        // Check if the path starts with the path separator or "../"
        return path.hasPrefix(pathSeperator) || path.hasPrefix(".." + pathSeperator)
    }
    
    /**
     * Tests if a path is a tilde path (i.e. starts with "~")
     * - Parameter path: The path to test
     * - Returns: True if the path is a tilde path, false otherwise
     */
    public static func isTildePath(_ path: String) -> Bool {
        // Check if the path starts with "~"
        return path.hasPrefix("~")
    }
}