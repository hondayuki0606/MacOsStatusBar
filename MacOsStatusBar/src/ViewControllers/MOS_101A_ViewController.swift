//
//  ViewController.swift
//  MacOsStatusBar
//
//  Created by 本田尚行 on 2020/10/08.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import Cocoa

class MOS_101A_ViewController: NSViewController, NSTextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBOutlet weak var UserID: NSTextField!
    @IBOutlet weak var Password: NSTextField!
    @IBOutlet weak var LoginButton: NSButton!
    @IBOutlet weak var ErrorMassage: NSTextField!
    
    
    @IBAction func LoginButton(_ sender: NSButton) {
         let userID:String = UserID.stringValue
         let password:String = Password.stringValue
         // ログインIDチェック
         if !userID.isAlphanumeric() {
            ErrorMassage.stringValue = "error1"
            return
         }
         // パスワードチェック
         if !password.isAlphanumeric() {
            ErrorMassage.stringValue = "error2"
            return
         }
         
         //ネットワーク接続（ログイン情報）
         let vm = MOS_101A_ViewModel()
         let result = vm.multipartPost(userID: userID, password: password)

         // ログイン処理成功時
        // if(result){
             // ステータスバー 表示処理
             let appDelegate = NSApplication.shared.delegate as! AppDelegate
             appDelegate.statusItem.isVisible = true
             appDelegate.constructMenu()

         //}
    }
}
extension String {
    // 半角数字の判定
    func isAlphanumeric() -> Bool {
        return self.range(of: "[^0-9]+", options: .regularExpression) == nil && self != ""
    }
    // 半角数字の判定
    func isAlphanumerics() -> Bool {
        return self.range(of: "[^0-9]+", options: .regularExpression) == nil && self != ""
    }
}
