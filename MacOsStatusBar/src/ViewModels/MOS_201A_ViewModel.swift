//
//  MOS_201A_ViewModel.swift
//  MacOsStatusBar
//
//  Created by 本田尚行 on 2020/10/20.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import Foundation

class MOS_201A_ViewModel {

    func multipartPost() {

        // API通信の情報生成
        let mo = MOS_201A_Model()
        mo.createMultiPartPost()

    }

}
