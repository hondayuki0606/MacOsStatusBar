//
//  APIClient.swift
//  MacOsStatusBar
//
//  Created by 本田尚行 on 2020/10/20.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import Foundation

class APIMultPort {
    
    func createMultiPartPost(parameters: [String: Any]) -> (headers: [String:String], body: Data) {

        let uniqueId = UUID().uuidString
        let now = NSDate() // 現在日時の取得

        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale // ロケールの設定
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss" // 日付フォーマットの設定
        
        let boundary = "---------------------------\(uniqueId)"

        let header = [
            "Content-Type" : "multipart/form-data; boundary=\(boundary)"
        ]

        var body = Data()

        let boundaryText = "--\(boundary)\r\n"


        for param in parameters {

            switch param.value {
                //画像情報の取得は無しのため削除
//            case let image as NSImage:
//
//                let imageData = image.jpegData(compressionQuality: 1.0)!
//
//                body.append(boundaryText.data(using: .utf8)!)
//                body.append("Content-Disposition: form-data; name=\"\(param.key)\"; filename=\"\(uniqueId).jpg\"\r\n".data(using: .utf8)!)
//                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
//
//                body.append(imageData)
//                body.append("\r\n".data(using: .utf8)!)

            case let string as String:

                body.append(boundaryText.data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(param.key)\";\r\n\r\n".data(using: .utf8)!)
                body.append(string.data(using: .utf8)!)
                body.append("\r\n".data(using: .utf8)!)

            case let value as Any:

                body.append(boundaryText.data(using: .utf8)!)

                // ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ここが問題↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
                body.append("Content-Disposition: form-data; name=\"\(param.key)\";\r\n\r\n".data(using: .utf8)!)
                body.append(String(describing: value).data(using: .utf8)!)
                body.append("\r\n".data(using: .utf8)!)

            default:
                break
            }
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        return (header, body)
    }

}
