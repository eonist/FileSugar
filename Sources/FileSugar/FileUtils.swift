#if os(OSX)
import Cocoa
/**
 * A utility class for working with files on macOS
 * - Fixme: ⚠️️ make this final?
 */
class FileUtils {
   /**
    * Shows where a file is in a finder window
    * - Description: Opens the Finder at the specified file path, allowing the user to view the location of the file or folder in the macOS Finder.
    * ## Examples:
    * showFileInFinder("~/dev/Element") -> shows the file or folder in finder
    * - Parameter filePath: The path of the file or folder to show in Finder
    */
   static func showFileInFinder(_ filePath: String) {
      // Expand the tilde in the file path to the user's home directory
      let expandedFilePath: String = filePath.tildePath
      // Use the shared NSWorkspace instance to select the file or folder in Finder
      NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: expandedFilePath)
   }
}
#endif
