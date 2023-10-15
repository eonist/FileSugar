import Foundation

extension String {
   /**
    * From user agnostic to absolute URL
    */
   internal var tildePath: String {
      // Convert the string to an NSString and expand the tilde in the path
      NSString(string: self).expandingTildeInPath
   }
}
