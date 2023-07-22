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
    * Asserts if a directory has files
    * - Fixme: ⚠️️ rename to hasDirContent?
    * - Fixme: ⚠️️ also add a method that asserts if a file has content?
    * ## Examples:
    * FileAsserter.hasContent(filePath: NSString(string: "~/Desktop/").expandingTildeInPath)
    * - Parameter filePath: - Fixme: ⚠️️ add doc
    */
   public static func hasContent(filePath: String) -> Bool {
      FileParser.content(dirPath: filePath)?.isEmpty ?? false
   }
}
