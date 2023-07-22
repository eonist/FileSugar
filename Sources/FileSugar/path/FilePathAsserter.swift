import Foundation

public final class FilePathAsserter {
   /**
    * Tests if a path is absolute /User/John/ or relative : ../../ or styles/design/
    * - Parameters:
    *   - path: - Fixme: ⚠️️ add doc
    *   - pathSeperator: - Fixme: ⚠️️ add doc
    */
    public static func isAbsolute(_ path: String, pathSeperator: String = "/") -> Bool {
        path.hasPrefix(pathSeperator)
    }
   /**
    * - Fixme: ⚠️️ Alternate name: hasBacklash ?
    * - Parameter path: - Fixme: ⚠️️ add doc
    */
    public static func isBacklash(_ path: String) -> Bool {
        path.hasPrefix("../")
    }
   /**
    * "Naive approach"
    * - Parameters:
    *   - path: - Fixme: ⚠️️ add doc
    *   - pathSeperator: - Fixme: ⚠️️ add doc
    */
    public static func isFilePath(_ path: String, pathSeperator: String = "/") -> Bool {
        path.hasPrefix(pathSeperator) || path.hasPrefix(".." + pathSeperator)
    }
   /**
    * Asserts if a path is a type of tilde path
    * - Parameter path: - Fixme: ⚠️️
    */
    public static func isTildePath(_ path: String) -> Bool {
        path.hasPrefix("~")
    }
}
