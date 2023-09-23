import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var window: NSWindow!
    /**
     * Creates the view
     */
    lazy var view: NSView = {
        let contentRect = window.contentRect(forFrameRect: window.frame) // Get the size of the window without the title bar
        let view: View = .init(frame: contentRect) // Create a new view with the same size as the window
        window.contentView = view // Set the window's content view to the new view
        view.layer?.backgroundColor = NSColor.white.cgColor // Set the background color of the view to white
        return view // Return the new view
    }()
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        _ = view
    }
}
