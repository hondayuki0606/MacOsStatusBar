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
    
    public var statusItem = NSStatusBar.system.draggableStatusItem(withLength: NSStatusItem.squareLength)
    
    public func changeMenubarIconImage(isDragging isDragIcon: Bool) {
        if let statusBarButton = statusItem.button {
            if isDragIcon {
                statusBarButton.image = NSImage(named:NSImage.Name("StatusBarButtonImageDragged"))
            } else {
                statusBarButton.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            }
        }
    }
    
    // アイコン表示・非表示設定
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.isVisible = false
        constructMenu()
    }
    
    // アイコン選択時のメニューバー
    func constructMenu() {
        let menu = NSMenu()
        // アイコン1番目
        menu.addItem(NSMenuItem(title: "Print1", action: #selector(AppDelegate.printQuote1(_:)), keyEquivalent: "P"))
        // アイコン2番目
        menu.addItem(NSMenuItem(title: "Print2", action: #selector(AppDelegate.printQuote2(_:)), keyEquivalent: "P"))
        // アイコン3番目
        menu.addItem(NSMenuItem(title: "Print3", action: #selector(AppDelegate.printQuote3(_:)), keyEquivalent: "P"))
        // アプリケーション終了処理を追加
        menu.addItem(NSMenuItem(title: "Quit Quotes", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        statusItem.menu = menu
    }
    
    // アイコン1番目選択時
    @objc func printQuote1(_ sender: Any?) {

        // OKがクリックされた時の処理
        let client = FontDownloadDialog()
        // サーバー処理実施
        client.fontDownload1()
    }
    
    // アイコン2番目選択時
    @objc func printQuote2(_ sender: Any?) {
        // OKがクリックされた時の処理
        let client = FontDownloadDialog()
        // サーバー処理実施
        client.fontDownload1()
    }
    
    // アイコン3番目選択時
    @objc func printQuote3(_ sender: Any?) {
        // OKがクリックされた時の処理
        let client = FontDownloadDialog()
        // サーバー処理実施
        client.fontDownload1()
    }
    
}

// ステータスの常駐アイコン設定
extension NSStatusBar {
    
    func draggableStatusItem(withLength length: CGFloat) -> NSStatusItem {
        let statusItem = self.statusItem(withLength: length)
        
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
        }
        
        return statusItem
    }
    
}
extension NSStatusBarButton {
    
}
