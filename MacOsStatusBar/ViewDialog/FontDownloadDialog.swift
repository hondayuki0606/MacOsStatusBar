//
//  APIClient.swift
//  CafeSearch
//
//  Created by 本田尚行 on 2020/09/17.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import Cocoa

class FontDownloadDialog {
    
    func fontDownload1() {
        
        let alert = NSAlert()
        
        // 表示メッセージとインフォメーション
        alert.messageText = "フォントダウンロード"
        alert.informativeText = "フォント1をダウンロードします。よろしいですか？"
        
        // メッセージのスタイル
        alert.alertStyle = .informational
        
        // ボタン追加
        alert.addButton(withTitle: "キャンセル")
        alert.addButton(withTitle: "OK")
        
        // ボタンに対してショートカットキーの設定する場合
        let buttons = alert.buttons
        buttons[0].keyEquivalent = "\u{1b}"    // esc key
        // buttons[0].tag = 1234               // runModalの戻り値を変更する場合
        buttons[1].keyEquivalent = "\r"        // enter key
        
        // 表示
        let ret = alert.runModal()

        switch ret {
        case .alertFirstButtonReturn:
            let cli = APIClient()
            cli.multipartPost()

        case .alertSecondButtonReturn:
            print("キャンセル")
        default:
            print("キャンセル:\(ret)")
        }
    }
}
