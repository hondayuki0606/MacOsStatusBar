//
//  ViewController.swift
//  MacOsStatusBar
//
//  Created by 本田尚行 on 2020/10/08.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController, NSTextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBOutlet weak var LoginID: NSTextField!
    @IBOutlet weak var Password: NSTextField!
    @IBOutlet weak var LoginButton: NSButton!
    @IBAction func LoginButton(_ sender: NSButton) {

        let login:String = LoginID.stringValue
        let password:String = Password.stringValue
        // ログインIDチェック
        if !login.isAlphanumeric() {
            return
        }
        // パスワードチェック
        if !password.isAlphanumeric() {
            return
        }
        
        //ネットワーク接続（ログイン情報）
        let logCli = LoginAPIClient()
        //let result = logCli.multipartPost(userID: login, password: password)
        
        // ステータスバー 表示処理
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        appDelegate.statusItem.isVisible = true
        appDelegate.constructMenu()

    }
    
}
extension String {
    // 半角数字の判定
    func isAlphanumeric() -> Bool {
        return self.range(of: "[^0-9]+", options: .regularExpression) == nil && self != ""
    }
}
