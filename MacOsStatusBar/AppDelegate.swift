//
//  AppDelegate.swift
//  NSMenuDemo
//
//  Created by 本田尚行 on 2020/10/08.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    public let statusItem = NSStatusBar.system.draggableStatusItem(withLength: NSStatusItem.squareLength)
    
    public func changeMenubarIconImage(isDragging isDragIcon: Bool) {
        if let statusBarButton = statusItem.button {
            if isDragIcon {
                statusBarButton.image = NSImage(named:NSImage.Name("StatusBarButtonImageDragged"))
            } else {
                statusBarButton.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            }
        }
    }
    
    public func receiveImageDraggedOnMenubarIcon(for urls: [URL]) {
        print("🍎URL Detected!")
        for url in urls {
            print(url)
        }
    }
    
    // アイコン表示・非表示設定
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.isVisible = true
        constructMenu()
    }
    
    
    // アイコン選択時のメニューバー
    func constructMenu() {
        let menu = NSMenu()
        // アイコン1番目
        menu.addItem(NSMenuItem(title: "Print", action: #selector(AppDelegate.printQuote(_:)), keyEquivalent: "P"))
        // アイコン2番目
        menu.addItem(NSMenuItem(title: "Print1", action: #selector(AppDelegate.printQuote1(_:)), keyEquivalent: "P"))
        //menu.addItem(NSMenuItem.separator())
        // アプリケーション終了処理を追加
        menu.addItem(NSMenuItem(title: "Quit Quotes", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        statusItem.menu = menu
    }
    
    // アイコン1番目選択時
    @objc func printQuote(_ sender: Any?) {
        let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
        let quoteAuthor = "Mark Twain"
        
        print("\(quoteText) — \(quoteAuthor)")
    }
    
    // アイコン2番目選択時
    @objc func printQuote1(_ sender: Any?) {
        let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
        let quoteAuthor = "Mark Twain1"
        
        print("\(quoteText) — \(quoteAuthor)")
    }
    
}

extension NSStatusBar {
    
    func draggableStatusItem(withLength length: CGFloat) -> NSStatusItem {
        let statusItem = self.statusItem(withLength: length)
        
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.registerForDraggedTypes([.fileURL, .tiff, .png, .URL, .string])
        }
        
        return statusItem
    }
}

extension NSStatusBarButton {
    
    
    // MARK: - Helper Methods
    
    private func filteringOptions() -> [NSPasteboard.ReadingOptionKey : Any] {
        return [.urlReadingContentsConformToTypes : NSImage.imageTypes]
    }
    
    private func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool {
        var canAccept = false
        let pasteBoard = draggingInfo.draggingPasteboard
        
        if pasteBoard.canReadObject(forClasses: [NSURL.self], options: filteringOptions()) ||
            pasteBoard.canReadObject(forClasses: [NSImage.self], options: filteringOptions()) {
            canAccept = true
        }
        
        return canAccept
    }
    
    private func setDraggingInfo(isDragging: Bool) {
        if let appDelegate = NSApplication.shared.delegate as? AppDelegate {
            appDelegate.changeMenubarIconImage(isDragging: isDragging)
        }
    }
    
    
    // MARK:- NSDraggingDestination Methods
    
    open override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        print("draggingEntered")
        
        let allow = shouldAllowDrag(sender)
        setDraggingInfo(isDragging: allow)
        
        return allow ? .copy : NSDragOperation()
    }
    
    
    open override func draggingExited(_ sender: NSDraggingInfo?) {
        setDraggingInfo(isDragging: false)
    }
    
    
    open override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        
        let pasteBoard = sender.draggingPasteboard
        
        // 今回はfileURLがドラッグされた場合のみ実装
        if let urls = pasteBoard.readObjects(forClasses: [NSURL.self], options: filteringOptions()) as? [URL],
            urls.count > 0,
            urls[0].isFileURL {
            
            if let appDelegate = NSApplication.shared.delegate as? AppDelegate {
                appDelegate.receiveImageDraggedOnMenubarIcon(for: urls)
            }
            
            return true
        }
        
        return false
    }
    
    
    open override func draggingEnded(_ sender: NSDraggingInfo) {
        setDraggingInfo(isDragging: false)
        print("draggingEnded")
    }
}
