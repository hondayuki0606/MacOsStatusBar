//
//  APIClient.swift
//  MacOsStatusBar
//
//  Created by 本田尚行 on 2020/10/20.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import Foundation

class MOS_101A_Model {
    
    let URL_SAVE_BOY = "http://10.207.171.16:8081/laravelapp/public/login.php"
    
    func createMultiPartPost(parameters: [String: Any]) {

        let url = URL(string: URL_SAVE_BOY)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let uniqueId = UUID().uuidString
        let now = NSDate() // 現在日時の取得

        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale // ロケールの設定
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss" // 日付フォーマットの設定
        
        let boundary = "---------------------------\(uniqueId)"

        let headers = [
            "Content-Type" : "multipart/form-data; boundary=\(boundary)"
        ]

        var body = Data()

        let boundaryText = "--\(boundary)\r\n"


        for param in parameters {

            switch param.value {
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

        // ヘッダーの設定
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }

        // Bodyの設定
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let response = response {
                print(response)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    print(json)
                } catch {
                    print("parse error")
                }
            } else {
                print(error ?? "unknown error")
            }
        }
        
        task.resume()
    }

}
