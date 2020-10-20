//
//  APIClient.swift
//  MacOsStatusBar
//
//  Created by 本田尚行 on 2020/10/20.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import Foundation

class APIClient {

    let URL_SAVE_BOY = "http://10.207.171.16:8081/laravelapp/public/input_do.php"
    
    func multipartPost() {

        let parameters:[String: Any]  = ["user_id": "hondayuki0606",
                                         "lat": 23.77,
                                         "lot": 99.222,
                                         "comment":  "comments",
                                         "hash_tag": "formatHashData",
                                         "user_tag": "friendHashData",
                                         "image": "self.imageView.image!"]
        
        let url = URL(string: URL_SAVE_BOY)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        let (headers, body) = APIClient.createMultiPartPost(parameters: parameters)

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

        // downloadTasl 実行例
        // let downtask = URLSession.shared.downloadTask(with: "https://"){
            
        //}
        task.resume()


    }

    static func createMultiPartPost(parameters: [String: Any]) -> (headers: [String:String], body: Data) {

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
//            case let image as UIImage:
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
