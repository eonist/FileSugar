import Foundation

public class FileAsserter {
    /**
     * EXAMPLE: FileAsserter.exists(path:"~/Desktop/del.txt".tildePath)//true or false (remember to expand the tildePath)
     * EXAMPLE:  NSString(string: self).expandingTildeInPath
     * NOTE: Also works for folders
     */
    public static func exists(path: String) -> Bool {
        return FileManager().fileExists(atPath: path)
    }
    /**
     * New
     */
    public static func hasContent(filePath: String) -> Bool {
        if let content: [String] = FileParser.contentOfDir(filePath) {
            return !content.isEmpty
        } else {
            return false
        }
    }
}
