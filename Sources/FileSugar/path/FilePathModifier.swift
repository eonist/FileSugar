import Foundation
/**
 * There is also tildify which makes file paths user agnostic (~ instad of hardocded user)
 * - Description: Provides methods for modifying and handling file paths, such as normalizing paths or expanding them to absolute paths.
 */
public final class FilePathModifier {
   /**
    * Normalizes a file path by resolving any symbolic links, removing any redundant path components, and returning an absolute path
    * - Description: This method takes a potentially complex or relative file path and simplifies it by resolving symbolic links, normalizing path components like "." and "..", and converting it to an absolute path if necessary. This ensures that the path is in a standard and predictable format, which is useful for file operations that require a canonical path.
    * ## Example:
    * let originalPath = "~/Documents/../Desktop/./file.txt"
    * let normalizedPath = FilePathModifier.normalize(originalPath) // "/Users/username/Desktop/file.txt"
    * - Parameter path: The path to normalize
    * - Returns: The normalized path, or nil if the path cannot be normalized
    */
   public static func normalize(_ path: String) -> String? {
      // Parse the path into a URL
      guard let url: URL = FilePathParser.path(path) else { return nil }
      // Normalize the URL by resolving any symbolic links and removing any redundant path components
      let normalizedURL: URL = url.standardized
      // Convert the normalized URL back to a path string
      return FilePathParser.path(normalizedURL)
   }
}
#if os(OSX)
import Cocoa
extension FilePathModifier {
   /**
    * Expands a file path to an absolute path
    * - Description: Expands a given file path into its absolute path form. This method handles tilde paths, relative paths, and absolute paths, ensuring the output is an absolute path. If a base URL is provided, it is used as the starting point for relative paths.
    * - Parameters:
    *   - filePath: The file path to expand
    *   - baseURL: The base URL to use when expanding relative paths (default is "")
    * - Returns: The expanded absolute path, or nil if the path cannot be expanded
    * ## Examples:
    * Swift.print(expand("/Users/John/Desktop/temp"))///Users/John/Desktop/temp
    * Swift.print(expand("~/Desktop/test.txt"))///Users/John/Desktop/test.txt
    * Swift.print(expand("/temp/colors/star.svg",baseURL:"/Users/John/Desktop"))///Users/John/Desktop/temp/colors/star.svg
    * Swift.print(expand("star.svg",baseURL:"/Users/John/Desktop"))///Users/John/Desktop/star.svg
    * - Important: ⚠️️ Tilde paths can't have backlash syntax like ../../ etc
    */
   public static func expand(_ filePath: String, baseURL: String = "") -> String? {
      switch true {
      case FilePathAsserter.isTildePath(filePath): // is tilde path
         return filePath.tildePath
      case FilePathAsserter.isBacklash(filePath): // is relative path
         let baseURL: String = baseURL.hasSuffix("/") ? baseURL : baseURL + "/"
         return FilePathModifier.normalize(baseURL + filePath) // returns absolute path
      case FileAsserter.exists(path: filePath): // absolute path that exists
         return filePath
      case FilePathAsserter.isAbsolute(filePath): // absolute but doesn't exist
         return baseURL + filePath
      default: // must be just a file name
         let baseURL: String = baseURL.hasSuffix("/") ? baseURL : baseURL + "/"
         return baseURL + filePath
      }
   }
}
#endif
