import Foundation
import AppKit

public class OkaPBManager {
    
    // MARK: - Public Properties
    public static let shared = OkaPBManager()
    
    public lazy var pasteboard = NSPasteboard.general

    // MARK: - Public APIs
    private var timer: Timer?
    
    private var lastChangeCount: Int = -1
    
    let serialQueue = OperationQueue()
    
    // MARK: monitor pasterboard change
    public func startMonitor() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            //            print("\(self.pasteboard.changeCount)")
            DispatchQueue.global().async {
                self.retreivePasteboardInfo()
            }
        })
    }
    
    public func stopMonitor() {
        timer?.invalidate()
        timer = nil
    }
    
   
    
    /// Get deep copy array of pb items from pasteboard
    /// - Returns: deep copy array of pb items
    private func getClonedPasteboardItems() -> [NSPasteboardItem]{
        if let items = pasteboard.pasteboardItems{
            let pbitems = items.map{$0.copy() as! NSPasteboardItem}
            return pbitems
        }else{
            return []
        }
    }
    

    
    @objc
    private func retreivePasteboardInfo() {
        guard pasteboard.changeCount != lastChangeCount else {
            return
        }
        lastChangeCount = pasteboard.changeCount
        let copyItems = getClonedPasteboardItems()
        print(copyItems)
    }
}




extension NSPasteboardItem: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let item = NSPasteboardItem()
        let cTypes = types
        for type in cTypes {
            if let data = data(forType: type) {
                item.setData(data, forType: type)
            }
        }
        
        return item
    }
    
}
