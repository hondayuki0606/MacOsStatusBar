//
//  MOS_101A_ViewModel.swift
//  MacOsStatusBar
//
//  Created by 本田尚行 on 2020/10/20.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import Foundation

class MOS_101A_ViewModel {

    func multipartPost(userID: String, password: String) {

        let parameters:[String: Any]  = ["user_id": userID,
                                         "password": password]
        // API通信の情報生成
        let mo = MOS_101A_Model()
        mo.createMultiPartPost(parameters: parameters)

    }

}
