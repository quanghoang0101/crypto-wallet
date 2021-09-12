//
//  Task.swift
//  cryto-wallet
//
//  Created by Hoang on 10/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

enum Task {
    case requestPlain
    case requestParameters(Parameters)
}
