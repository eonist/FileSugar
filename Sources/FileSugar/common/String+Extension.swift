import Foundation

extension String {
   /**
    * from user agnostic to absolute URL
    */
   internal var tildePath: String { NSString(string: self).expandingTildeInPath }
}
