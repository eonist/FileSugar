import Foundation

public final class FileModifier {
   /**
    * Moves a file from one location to another
    * - Description: Moves a file from its current location to a new location specified by the user.
    * - Remark: Paths must be created with: URL(fileURLWithPath: directory) and then .path
    * ## Examples:
    * FileModifier.move("~/Desktop/old.txt".tildePath, "~/Desktop/newFolder/old.txt".tildePath) // returns true if the file was successfully moved
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
    * - Description: Copies a file from its current location to a new location specified by the user.
    * - Remark: Paths must be created with: URL(fileURLWithPath: directory) and then .path
    * ## Examples:
    * FileModifier.copy("~/Desktop/old.txt".tildePath, "~/Desktop/newFolder/old.txt".tildePath) // returns true if the file was successfully copied
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
    * - Description: Writes the provided string content to the file at the specified path. If the file does not exist, it is created. If the file exists, its contents are overwritten.
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
    * - Description: Writes the provided data to the file at the specified path. If the file does not exist, it is created. This method is useful for writing raw data like binary content.
    * ## Examples:
    * FileModifier.write("~/Desktop/del.txt".tildePath, data) // returns true or false depending on if something was written or not
    * Fixme: this should throw?
    * - Parameters:
    *   - path: The path of the file to write to
    *   - data: The data to write to the file
    * - Returns: A boolean value indicating whether the data was successfully written to the file
    */
   @discardableResult public static func write(path: String, data: Data) throws -> Bool {
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
    * - Description: Creates a directory at the specified path. If any intermediate directories do not exist, they will be created as well.
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
    * - Description: Deletes the file at the specified path. This operation is irreversible.
    * Example:
    * FileModifier.delete("~/Desktop/old_file.txt".tildePath) // returns true if the file was successfully deleted
    * - Parameter path: The path of the file to delete
    * - Returns: A boolean value indicating whether the file was successfully deleted
    */
   @discardableResult public static func delete(_ path: String) -> Bool {
      let fileManager: FileManager = .default // create a file manager instance
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
    * - Description: Renames the file at the specified path to a new path. This operation changes the file's location and/or its name within the filesystem.
    * Example:
    * FileModifier.rename("~/Desktop/old_name.txt".tildePath, "~/Desktop/new_name.txt".tildePath) // returns true if the file was successfully renamed
    * - Parameters:
    *   - fromURL: The path of the file to rename
    *   - toURL: The new path for the renamed file
    * - Returns: A boolean value indicating whether the file was successfully renamed
    */
   @discardableResult public static func rename(_ fromURL: String, toURL: String) -> Bool {
      let fileManager: FileManager = .default // create a file manager instance
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
    * - Description: Creates a folder at the specified path. This operation includes the creation of intermediate directories if they do not exist.
    * Example:
    * FileModifier.createFolder("~/Desktop/new_folder".tildePath) // returns true if the folder was successfully created
    * - Parameter path: The path of the folder to create
    * - Returns: A boolean value indicating whether the folder was successfully created
    */
   @discardableResult public static func createFolder(_ path: String) -> Bool {
      let fileManager: FileManager = .default // create a file manager instance
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
    * - Description: Appends the specified text to the end of the file at the given path.
    * Example:
    * FileModifier.append("~/Desktop/log.txt".tildePath, "New log entry") // returns true if the text was successfully appended
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
    * - Description: Appends the specified text to the file at the given path and index. If the index is beyond the current file length, the text will be appended at the end.
    * Example:
    * FileModifier.append("~/Desktop/log.txt".tildePath, "New log entry", index: 10) // returns true if the text was successfully appended at the specified index
    * - Parameters:
    *   - path: The path of the file to append to
    *   - text: The text to append to the file
    *   - index: The index at which to append the text
    * - Returns: A boolean value indicating whether the text was successfully appended to the file
    */
   @discardableResult public static func append(_ path: String, text: String, index: Int) -> Bool {
      guard let os: OutputStream = .init(toFileAtPath: path, append: true) else { return false } // create an output stream to the file at the specified path
      os.open() // open the output stream
      os.write(text, maxLength: index) // write the text to the output stream at the specified index
      os.close() // close the output stream
      return true // return true if the text was successfully appended to the file
   }
}
// async
extension FileModifier {
    /**
     * Writes the given content to a file asynchronously.
     * - Parameters:
     *   - url: The URL of the file to write to.
     *   - content: The string content to write to the file.
     * - Throws: An error if the content could not be written.
     */
    public static func writeContentAsync(url: URL, content: String) async throws {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global().async {
                do {
                    try content.write(to: url, atomically: true, encoding: .utf8)
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    /**
     * Writes the given data to a file asynchronously.
     * - Parameters:
     *   - url: The URL of the file to write to.
     *   - data: The data to write to the file.
     * - Throws: An error if the data could not be written.
     */
    public static func writeDataAsync(url: URL, data: Data) async throws {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global().async {
                do {
                    try data.write(to: url, options: .atomic)
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
   /**
    * Appends text to a file asynchronously at a specified index.
    * - Description: Opens a file at the given path and appends the provided text starting from the specified index. If the index is negative, the text is appended at the end of the file.
    * - Parameters:
    *   - path: The path to the file where the text will be appended.
    *   - text: The text content to append to the file.
    *   - index: The position in the file where the text will be appended. If negative, the text is appended to the end.
    * - Returns: A boolean indicating whether the append operation was successful.
    * - Throws: An error if the file cannot be opened or written to.
    */
   public static func appendAsync(_ path: String, text: String, index: Int) async throws -> Bool {
       let fileURL = URL(fileURLWithPath: path)
       guard let data = text.data(using: .utf8) else {
           throw NSError(domain: "Invalid Encoding", code: -1, userInfo: nil)
       }
       return try await withCheckedThrowingContinuation { continuation in
           DispatchQueue.global().async {
               do {
                   let fileHandle = try FileHandle(forWritingTo: fileURL)
                   defer {
                       try? fileHandle.close()
                   }
                   if index >= 0 {
                       try fileHandle.seek(toOffset: UInt64(index))
                   } else {
                       try fileHandle.seekToEnd()
                   }
                   try fileHandle.write(contentsOf: data)
                   continuation.resume(returning: true)
               } catch {
                   continuation.resume(throwing: error)
               }
           }
       }
   }
}
