//
//  NSObject+ClassName.swift
//  cryto-wallet
//
//  Created by Hoang on 09/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}
