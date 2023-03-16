import Foundation

public final class FileAsserter {
   /**
    * Asserts if a file or folder exists
    * ## Examples:
    * FileAsserter.exists(path: NSString(string: "~/Desktop/del.txt").expandingTildeInPath) // true or false (remember to expand the tildePath)
    * - Parameter path: - Fixme: ⚠️️
    */
   public static func exists(path: String) -> Bool {
      FileManager().fileExists(atPath: path)
   }
   /**
    * Asserts if a file has content
    * ## Examples:
    * FileAsserter.hasContent(filePath: NSString(string: "~/Desktop/del.txt").expandingTildeInPath)
    * - Parameter filePath: - Fixme: ⚠️️
    */
   public static func hasContent(filePath: String) -> Bool {
      FileParser.content(dirPath: filePath)?.isEmpty ?? false
   }
}
