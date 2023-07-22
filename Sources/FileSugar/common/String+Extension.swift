import Foundation

extension String {
   /**
    * From user agnostic to absolute URL
    */
   internal var tildePath: String { NSString(string: self).expandingTildeInPath }
}
