import Foundation

extension String {
   /**
    * From user agnostic to absolute URL
    * ## Example:
    * let path = "~/Documents/example.txt"
    * let absolutePath = path.tildePath // "/Users/username/Documents/example.txt"
    * - Description: Converts a user-agnostic path (starting with "~") to an absolute path by expanding the tilde to the current user's home directory.
    */
   internal var tildePath: String {
      // Convert the string to an NSString and expand the tilde in the path
      NSString(string: self).expandingTildeInPath
   }
}
