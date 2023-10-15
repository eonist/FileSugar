import Foundation

public final class FileAsserter {
   /**
    * Asserts if a file or folder exists
    * ## Examples:
    * FileAsserter.exists(path: NSString(string: "~/Desktop/del.txt").expandingTildeInPath) // true or false (remember to expand the tildePath)
    * - Parameter path: The path of the file or folder to check for existence
    * - Returns: A boolean value indicating whether the file or folder exists
    */
   public static func exists(path: String) -> Bool {
      // Create a new instance of the FileManager class
      FileManager()
         // Check if a file exists at the given path
         .fileExists(atPath: path)
   }

   /**
    * Asserts if a directory has files
    * ## Examples:
    * FileAsserter.hasContent(filePath: NSString(string: "~/Desktop/").expandingTildeInPath)
    * - Parameter filePath: The path of the directory to check for files
    * - Returns: A boolean value indicating whether the directory has files
    */
   public static func hasContent(filePath: String) -> Bool {
      // Call the content method of the FileParser class with the given directory path
      FileParser.content(dirPath: filePath)?
         // Check if the returned content is empty
         .isEmpty ?? false
   }
}
