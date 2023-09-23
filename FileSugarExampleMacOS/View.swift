import Cocoa

open class View: NSView {
   override open var isFlipped: Bool { true } // TopLeft orientation
   override public init(frame: CGRect) {
      super.init(frame: frame)
      Swift.print("hello world")
      test1()
      self.wantsLayer = true // if true then view is layer backed
   }
   /**
    * Boilerplate
    */
   @available(*, unavailable)
   public required init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
/**
 * Test
 */
extension View {
   /**
    * Testing getting content from folder
    */
   func test1() {
      // Call the content method of the FileParser class with the expanded tilde path
      let result = FileParser.content(dirPath: NSString(string: "~/Desktop/").expandingTildeInPath)
      // Print the count of the result array
      Swift.print("result.count:  \(String(describing: result?.count))")
      result?.forEach {
         Swift.print("$0:  \($0)") // prints all the files on the desktop folder
      }
   }
}
