import Foundation

public class FilePathAsserter {
    /**
     * Tests if a path is absolute /User/John/ or relative : ../../ or styles/design/
     */
    public static func isAbsolute(_ path:String, pathSeperator:String = "/") -> Bool{
        return path.hasPrefix(pathSeperator)
    }
    public static func isBacklash(_ path:String) -> Bool{//the name is not great, improve later
        return path.hasPrefix("../")
    }
    /**
     * New, naive approche
     */
    public static func isFilePath(_ path:String,pathSeperator:String = "/") -> Bool{
        return path.hasPrefix(pathSeperator) || path.hasPrefix(".."+pathSeperator)
    }
    /**
     * New
     */
    public static func isTildePath(_ path:String) -> Bool{
        return path.hasPrefix("~")
    }
}
