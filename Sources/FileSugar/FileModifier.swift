import Foundation

public final class FileModifier {
   /**
    * Moves a file from one location to another
    * - Remark: Paths must be created with: URL(fileURLWithPath: directory) and then .path
    * - Parameters:
    *    - fromURL: The path of the file to move
    *    - toURL: The path of the destination for the file
    * - Returns: A boolean value indicating whether the file was successfully moved
    */
   @discardableResult public static func move(_ fromURL: String, toURL: String) -> Bool {
      let fileManager = FileManager.default // create a file manager instance
      let fromURL: URL = .init(fileURLWithPath: fromURL) // create a URL from the source file path
      let toURL: URL = .init(fileURLWithPath: toURL) // create a URL from the destination file path
      do {
         try fileManager.moveItem(at: fromURL, to: toURL) // move the file from the source to the destination
         return true // return true if the file was successfully moved
      } catch let error as NSError {
         print("Error: \(error.domain)") // print the error message if the file move operation failed
         return false // return false if the file move operation failed
      }
   }
   /**
    * Copies a file to another location
    * - Remark: Paths must be created with: URL(fileURLWithPath: directory) and then .path
    * - Parameters:
    *   - fromURL: The path of the file to copy
    *   - toURL: The path of the destination for the copied file
    * - Returns: A boolean value indicating whether the file was successfully copied
    */
   @discardableResult public static func copy(_ fromURL: String, toURL: String) -> Bool {
      let fileManager = FileManager.default // create a file manager instance
      let fromURL: URL = .init(fileURLWithPath: fromURL) // create a URL from the source file path
      let toURL: URL = .init(fileURLWithPath: toURL) // create a URL from the destination file path
      do {
         try fileManager.copyItem(at: fromURL, to: toURL) // copy the file from the source to the destination
         return true // return true if the file was successfully copied
      }
      catch let error as NSError {
         print("⚠️️ copy.Error: \(error)") // print the error message if the file copy operation failed
         return false // return false if the file copy operation failed
      }
   }

   /**
    * Writes a string to a file
    * - Examples:
    * FileModifier.write("~/Desktop/del.txt".tildePath, "test") // returns true or false depending on if something was written or not
    * - Remark: This method overwrites data to files that already exist as well
    * - Remark: This method creates a new file if it doesn't exist before
    * - Parameters:
    *   - path: The path of the file to write to
    *   - content: The string to write to the file
    * - Returns: A boolean value indicating whether the string was successfully written to the file
    */
   @discardableResult public static func write(_ path: String, content: String) -> Bool {
      do {
         try content.write(toFile: path, atomically: true, encoding: .utf8) // write the string to the file at the specified path
         return true // return true if the string was successfully written to the file
      } catch {
         print("failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding") // print an error message if the write operation failed
         return false // return false if the write operation failed
      }
   }
   /**
    * Write data to path
    * ## Examples:
    * FileModifier.write("~/Desktop/del.txt".tildePath, data) // returns true or false depending on if something was written or not
    * Fixme: this should throw?
    * - Parameters:
    *   - path: The path of the file to write to
    *   - data: The data to write to the file
    * - Returns: A boolean value indicating whether the data was successfully written to the file
    */
   @discardableResult public static func write(path: String, data: Data) -> Bool {
      do {
         try data.write(to: URL(fileURLWithPath: path), options: [.atomic]) // write the data to the file at the specified path
         return true // return true if the data was successfully written to the file
      } catch let error {
         print("failed to write file – bad permissions, bad filename, missing permissions, or something else error: \(error.localizedDescription)") // print an error message if the write operation failed
         return false // return false if the write operation failed
      }
   }
   /**
    * Create a directory at a path
    * - Remark: Also creates entire structures of folders say if non of the folders in path desktop/temp/tmp/blabla already exists, then all 3 folders will be created
    * ## Examples:
    * FileModifier.createDir("~/Desktop/temp/".tildePath) // returns true or false depending on if something was created or not
    * - Parameter path: The path of the directory to create
    * - Returns: A boolean value indicating whether the directory was successfully created
    */
   @discardableResult public static func createDir(path: String) -> Bool {
      do {
         try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil) // create the directory at the specified path, including any intermediate directories that don't exist
         return true // return true if the directory was successfully created
      } catch let error {
         Swift.print("Unable to create directory \(error.localizedDescription)") // print an error message if the directory creation failed
         return false // return false if the directory creation failed
      }
   }
   /**
    * Deletes a file at a specific path
    * - Parameter path: The path of the file to delete
    * - Returns: A boolean value indicating whether the file was successfully deleted
    */
   @discardableResult public static func delete(_ path: String) -> Bool {
      let fileManager = FileManager.default // create a file manager instance
      do {
         try fileManager.removeItem(atPath: path) // delete the file at the specified path
         return true // return true if the file was successfully deleted
      }
      catch let error as NSError {
         print("delete.Error: \(error)") // print an error message if the file deletion failed
         return false // return false if the file deletion failed
      }
   }
   /**
    * Renames a file
    * - Parameters:
    *   - fromURL: The path of the file to rename
    *   - toURL: The new path for the renamed file
    * - Returns: A boolean value indicating whether the file was successfully renamed
    */
   @discardableResult public static func rename(_ fromURL: String, toURL: String) -> Bool {
      let fileManager = FileManager.default // create a file manager instance
      do {
         try fileManager.moveItem(atPath: fromURL, toPath: toURL) // rename the file at the specified path to the new path
         return true // return true if the file was successfully renamed
      } catch let error as NSError {
         print("FileModifier.rename() Error: \(error)") // print an error message if the file rename operation failed
         return false // return false if the file rename operation failed
      }
   }
   /**
    * Creates a folder at a specific path
    * - Parameter path: The path of the folder to create
    * - Returns: A boolean value indicating whether the folder was successfully created
    */
   @discardableResult public static func createFolder(_ path: String) -> Bool {
      let fileManager = FileManager.default // create a file manager instance
      do {
         try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil) // create the folder at the specified path, including any intermediate directories that don't exist
         return true // return true if the folder was successfully created
      } catch let error as NSError {
         Swift.print("⚠️️ FileModifier.createFolder() Error: \(error)") // print an error message if the folder creation failed
         return false // return false if the folder creation failed
      }
   }
   /**
    * Append text to end of file
    * - Parameters:
    *   - path: The path of the file to append to
    *   - text: The text to append to the file
    * - Returns: A boolean value indicating whether the text was successfully appended to the file
    */
   @discardableResult public static func append(_ path: String, text: String) -> Bool {
      append(path, text: text, index: text.lengthOfBytes(using: .utf8)) // call the append method with the default index value (end of file)
   }

   /**
    * Append text to file at index
    * - Parameters:
    *   - path: The path of the file to append to
    *   - text: The text to append to the file
    *   - index: The index at which to append the text
    * - Returns: A boolean value indicating whether the text was successfully appended to the file
    */
   @discardableResult public static func append(_ path: String, text: String, index: Int) -> Bool {
      guard let os = OutputStream(toFileAtPath: path, append: true) else { return false } // create an output stream to the file at the specified path
      os.open() // open the output stream
      os.write(text, maxLength: index) // write the text to the output stream at the specified index
      os.close() // close the output stream
      return true // return true if the text was successfully appended to the file
   }
}
