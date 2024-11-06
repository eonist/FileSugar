import Foundation
/**
 * The `FileParser` class provides utility methods for working with files and directories.
 * It includes methods for reading and writing file contents, getting file attributes, and more.
 * All methods are static, so there is no need to create an instance of this class to use them.
 */
public final class FileParser {
   /**
    * Get data for URL
    * - Description: Retrieves the raw data from the file located at the specified URL.
    * ## Examples:
    * let url = URL(fileURLWithPath: "~/Desktop/example.txt")
    * let data = FileParser.data(url: url)
    * Swift.print(data) // Output: Optional(<file data>)
    * - Parameter url: The URL of the file to get data from
    * - Returns: The data of the file at the specified URL, or nil if an error occurred
    */
   public static func data(url: URL) -> Data? {
      do {
         let content: Data = try .init(contentsOf: url) // read the contents of the file at the specified URL
         return content // return the contents of the file
      } catch {
         return nil // return nil if an error occurred
      }
   }
   /**
    * Get data for file at a specific path
    * - Description: Retrieves the raw data from the file located at the specified file path.
    * ## Examples:
    * let filePath = "~/Desktop/example.txt"
    * let data = FileParser.data(filePath: filePath.tildePath)
    * Swift.print(data) // Output: Optional(<file data>)
    * - Parameter filePath: The path of the file to get data from
    * - Returns: The data of the file at the specified path, or nil if an error occurred
    */
   public static func data(filePath: String) -> Data? {
      do {
         let url: URL = .init(fileURLWithPath: filePath) // create a URL from the file path
         let content: Data = try .init(contentsOf: url) // read the contents of the file at the specified path
         return content // return the contents of the file
      } catch let error as NSError {
         Swift.print("⚠️️ Error: \(error)") // print an error message if an error occurred
         return nil // return nil if an error occurred
      }
   }
   /**
    * Returns string content from a file at file location "path"
    * - Description: Retrieves the string content from the file located at the specified path.
    * - Important: ⚠️️ Remember to expand the path with the .tildePath call, if it's a tilde path
    * - Remark: Supports syntax like this: `/Users/John/Desktop/temp/../test.txt` (the temp folder is excluded in this case)
    * ## Examples:
    * let path = "//Users/<path>/someFile.xml"
    * var err: NSError?
    * let content = String.stringWithContentsOfFile(path, encoding: NSUTF8StringEncoding, error: &err)
    * ## Examples:
    * FileParser.content(dirPath: NSString(string: "~/Desktop/temp.txt").expandingTildeInPath)
    * - Parameters:
    *   - path: is the file path to the file in this format: `User/John/Desktop/test.txt` aka absolute
    *   - encoding: The encoding to use when reading the file (default is UTF-8)
    * - Returns: The string content of the file at the specified path, or nil if an error occurred
    */
   public static func content(filePath path: String, encoding: String.Encoding = .utf8) -> String? {
      do {
         let content: String = try .init(contentsOfFile: path, encoding: encoding) // read the contents of the file at the specified path with the specified encoding
         return content // return the contents of the file
      } catch  let error as NSError {
         Swift.print("⚠️️ Error: \(error)") // print an error message if an error occurred
         return nil // return nil if an error occurred
      }
   }
   /**
    * Get the string content of a resource file in the main bundle
    * - Description: Retrieves the string content from a resource file located within the app's main bundle.
    * ## Examples:
    * Swift.print(FileParser.content(FilePathParser.resourcePath() + "/temp.bundle/test.txt"))
    * - Parameters:
    *   - fileName: The name of the resource file to get the content of
    *   - fileExtension: The extension of the resource file to get the content of
    * - Returns: The string content of the resource file, or nil if the file was not found or an error occurred
    */
   public static func resourceContent(_ fileName: String, fileExtension: String) -> String? {
      guard let filepath: String = Bundle.main.path(forResource: fileName, ofType: fileExtension) else {
         return nil
      } // get the file path of the resource file with the specified name and extension in the main bundle
      return content(filePath: filepath) // return the string content of the resource file
   }
   /**
    * Get the modification date of a file at a specific path
    * - Description: Retrieves the modification date of the file at the specified path.
    * - Remark: Make sure the file exists with: `FileAsserter.exists("some path here")`
    * - Parameter filePath: The absolute path of the file to get the modification date of
    * ## Examples:
    * let filePath: String = NSString(string: "~/Desktop/test.txt").expandingTildeInPath
    * let date: Date? = FileParser.modificationDate()
    * - Returns: The modification date of the file at the specified path, or nil if an error occurred
    */
   public static func modificationDate(_ filePath: String) -> NSDate? {
      let fileURL: NSURL = .init(fileURLWithPath: filePath) // create a file URL from the specified file path
      guard let attributes: [URLResourceKey: Any] = try? fileURL.resourceValues(forKeys: [URLResourceKey.contentModificationDateKey, URLResourceKey.nameKey]) else {
         return nil
      } // get the resource values for the file URL, including the modification date
      guard let modificationDate: NSDate = attributes[URLResourceKey.contentModificationDateKey] as? NSDate else { return nil } // get the modification date from the resource values
      return modificationDate // return the modification date of the file
   }
   /**
    * Returns paths of content in a directory
    * - Description: Retrieves the paths of all files and directories within the specified directory.
    * - Note: This method returns the paths of all files and directories in the specified directory
    * - Remark: This is the root folder of the main hard drive on your computer
    * ## Examples:
    * let filePath = NSString(string: "~/Desktop/").expandingTildeInPath
    * FileParser.content(dirPath: filePath)
    * - Parameter path: The path of the directory to get the contents of
    * - Returns: An array of strings representing the paths of all files and directories in the specified directory, or nil if an error occurred
    */
   public static func content(dirPath path: String) -> [String]? {
      let fileManager: FileManager = .default // create a file manager instance
      do {
         let files: [String] = try fileManager.contentsOfDirectory(atPath: path) // get the contents of the directory at the specified path
         return files // return the paths of all files and directories in the specified directory
      } catch let error as NSError {
         Swift.print("⚠️️ FileParser.content Error: \(error)") // print an error message if an error occurred
         return nil // return nil if an error occurred
      }
   }
   /**
    * Returns temporary directory path
    * - Description: Retrieves the path to the system's temporary directory, which is used to store temporary files and data.
    * ## Examples:
    * let tempDirectoryPath = FileParser.tempPath
    * Swift.print("Temporary directory path: \(tempDirectoryPath)")
    * - Returns: The path of the temporary directory
    */
   public static var tempPath: String {
      NSTemporaryDirectory() as String // get the path of the temporary directory
   }
   /**
    * Returns the current directory path
    * - Description: Retrieves the path of the current working directory.
    * ## Examples:
    * let currentDirectoryPath = FileParser.curDir
    * Swift.print("Current directory path: \(currentDirectoryPath)")
    * - Returns: The path of the current directory
    */
   public static var curDir: String {
      let fileManager: FileManager = .default // create a file manager instance
      return fileManager.currentDirectoryPath // get the path of the current directory
   }
}
#if os(OSX)
import Cocoa
/**
 * Fileparsing for mac only
 */
extension FileParser {
   /**
    * Returns an xml instance comprised of the string content at location path
    * - Description: Parses the XML content from the specified file path and returns the root XML element.
    * ## Examples:
    * xml("~/Desktop/assets/xml/table.xml".tildePath) // Output: XML instance
    * - Important: ⚠️️ Remember to expand the "path" with the tildePath call before you call xml(path)
    * - Parameter path: The path of the file to get the XML content from
    * - Returns: An XMLElement instance representing the root element of the XML content at the specified path, or nil if an error occurred
    */
   public static func xml(_ path: String) -> XMLElement? {
      guard let content: String = FileParser.content(filePath: path) else { fatalError("Must have content: path: \(path)") } // get the string content of the file at the specified path
      do {
         let xmlDoc: XMLDocument = try XMLDocument(xmlString: content, options: XMLNode.Options(rawValue: 0)) // create an XML document instance from the string content
         return xmlDoc.rootElement() // return the root element of the XML document
      } catch let error as NSError {
         Swift.print("⚠️️ FileParser.xml Error: \(error.domain) path:\(path)") // print an error message if an error occurred
         return nil // return nil if an error occurred
      }
   }
   /**
    * Example method that demonstrates how to use an NSOpenPanel to choose a file and get its content
    * - Description: Demonstrates the use of NSOpenPanel to select a file and retrieve its content.
    * ## Examples:
    * FileParser.modalExample() // Opens a file dialog, user selects a file, prints its content
    * - Remark: This method is an example and should be modified to fit your specific use case
    */
   private static func modalExample() {
      let myFileDialog: NSOpenPanel = .init() // Create an NSOpenPanel instance
      myFileDialog.runModal() // Open the modal panel to choose a file
      let thePath: String? = myFileDialog.url?.path // get the path to the file chosen in the NSOpenPanel
      if let thePath: String = thePath,
         let theContent: String = FileParser.content(filePath: thePath) { // make sure that a path was chosen and get the content of the file
         Swift.print("theContent: " + "\(theContent)") // print the content of the file
      }
   }
}
#endif
