import Foundation

public class FileUtils {//rename to FileUtil
   /**
    * - NOTE: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSWorkspace_Class/index.html#//apple_ref/occ/instm/NSWorkspace/openURL:
    * - Fixme: ⚠️️ what format is the filePath in?
    * ## EXAMPLES:
    * openFile((path to desktop as text) & "del.txt")
    */
   public static func openFile(_ filePath: String) {
      fatalError("out of order")
      //log file_path
      //NSWorkspace.openFile(filePath)
   }
   /**
    * PARAM: filePaths is an array of file paths
    */
   public static func openFiles(_ filePaths: [String]) {
      filePaths.forEach { openFile($0) }
   }
}

#if os(OSX)
import Cocoa

extension FileUtils {
   /**
    * showFileInFinder("~/dev/Element") -> shows the file or folder in finder
    */
   public static func showFileInFinder(_ filePath: String) {
      let expandedFilePath: String = filePath.tildePath
      NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: expandedFilePath)
   }
}
#endif
