//
//  MOS_203A_ViewModel.swift
//  MacOsStatusBar
//
//  Created by 本田尚行 on 2020/10/20.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import Foundation

class MOS_203A_ViewModel {

    let URL_SAVE_BOY = "http://10.207.171.16:8081/laravelapp/public/login.php"
    
    func multipartPost() {

        let parameters:[String: Any]  = ["user_id": "userID",
                                         "password": "password"]
        
        let url = URL(string: URL_SAVE_BOY)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        // API通信の情報生成
        let mo = MOS_101A_Model()
        //let (headers, body) = mo.createMultiPartPost(parameters: parameters)

//        // ヘッダーの設定
//        for header in headers {
//            request.addValue(header.value, forHTTPHeaderField: header.key)
//        }
//
//        // Bodyの設定
//        request.httpBody = body
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data, let response = response {
//                print(response)
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
//                    print(json)
//                } catch {
//                    print("parse error")
//                }
//            } else {
//                print(error ?? "unknown error")
//            }
//        }
//
//        task.resume()

    }

}
