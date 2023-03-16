#if os(OSX)
import Cocoa
/**
 * Applies only to macOS
 */
class FileUtils {
   /**
    * Shows where a file is in a finder window
    * ## Examples:
    * showFileInFinder("~/dev/Element") -> shows the file or folder in finder
    * - Parameter filePath: - Fixme: ⚠️️ 
    */
   static func showFileInFinder(_ filePath: String) {
      let expandedFilePath: String = filePath.tildePath
      NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: expandedFilePath)
   }
}
#endif
