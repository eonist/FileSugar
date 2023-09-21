import Foundation
/**
 * There is also tildify which makes file paths user agnostic (~ instad of hardocded user)
 */
public final class FilePathModifier {
   /**
    * Normalizes a file path by resolving any symbolic links, removing any redundant path components, and returning an absolute path
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
    * - Parameter filePath: The file path to expand
    * - Parameter baseURL: The base URL to use when expanding relative paths (default is "")
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
         let baseURL = baseURL.hasSuffix("/") ? baseURL : baseURL + "/"
         return FilePathModifier.normalize(baseURL + filePath) // returns absolute path
      case FileAsserter.exists(path: filePath): // absolute path that exists
         return filePath
      case FilePathAsserter.isAbsolute(filePath): // absolute but doesn't exist
         return baseURL + filePath
      default: // must be just a file name
         let baseURL = baseURL.hasSuffix("/") ? baseURL : baseURL + "/"
         return baseURL + filePath
      }
   }
}
#endif
