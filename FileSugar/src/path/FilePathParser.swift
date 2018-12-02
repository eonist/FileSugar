import Foundation

public class FilePathParser {
    /**
     * Returns the path to where you can save your app's files. Here it is:
     * Output: /Users/James/Documents
     */
    public static func appDocPath() -> String?{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths.first
    }
    /**
     * EXAMPLE: path("file:///Users/Me/Desktop/Doc.txt")/NSURL obj
     */
    public static func path(_ stringPath:String) -> URL?{
        return URL(string: stringPath)
    }
    /**
     * EXAMPLE: path(NSURL("file:///Users/Me/Desktop/Doc.txt"))//Users/Me/Desktop/Doc.txt
     */
    public static func path(_ url:URL) -> String{
        return url.path
    }
    /**
     * EXAMPLE: stringPath(path("file:///Users/Me/Desktop/Doc.txt"))//"file:///Users/Me/Desktop/Doc.txt"
     */
    public static func stringPath(_ path:URL) -> String{
        return path.absoluteString
    }
    /**
     * NOTE: You can also do: NSString(string: self).stringByExpandingTildeInPath
     */
    public static func userHomePath() -> String{
        return NSHomeDirectory()
    }
    /**
     * RETURNS: fileName
     * EXAMPLE: FilePathParser.fileName(fileURL)
     * NOTE: you can also use: 
     * let attributes = try! URL(fileURLWithPath:"~/Desktop/temp.xml".tildePath).resourceValuesForKeys([NSURLContentModificationDateKey, NSURLNameKey])
     * let filename = attributes[NSURLNameKey] as! String
     * NOTE: you can also do:  let fileName = url.lastPathComponent//file.zip etc
     */
    public static func fileName(_ fileURL:URL, _ withExtension:Bool = true)->String{
        return withExtension ? fileURL.absoluteURL.lastPathComponent : fileURL.absoluteURL.deletingPathExtension().lastPathComponent//was-> absoluteURL.URLByDeletingPathExtension before swift 3 upgrade
    }
    /**
     * EXAMPLE: fileName("~/Desktop/temp.xml")//temp.xml
     */
    public static func fileName(path filePath:String,withExtension:Bool = true) -> String?{
        guard let url:URL = path(filePath) else {return nil}
        return fileName(url, withExtension)
    }
    /**
     * Returns directory
     * EXAMPLE: FilePathParser.directory(fileURL)
     */
    public static func directory(_ fileURL:URL) -> String{
        return fileURL.absoluteURL.deletingPathExtension().absoluteString
    }
    /**
     * Returns the project resource folder
     * NOTE: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSBundle_Class/
     * Example: Swift.print(FileParser.content(FilePathParser.resourcePath() + "/temp.bundle/test.txt"))
     */
    public static var resourcePath:String? {
        return Bundle.main.resourcePath
    }
    /**
     * fileExtension("~/Desktop/temp.xml")//xml
     * NOTE: Does not need tilde expand to work
     */
    public static func fileExtension(_ filePath:String) -> String{
        return NSString(string:filePath).pathExtension
    }
 
}
public extension FilePathParser{
    /**
     * Convenience
     */
    static func fileName(fileURL:String, _ withExtension:Bool = true) -> String?{
        guard let path = path(fileURL) else {return nil}
        return fileName(path, withExtension)
    }
}
