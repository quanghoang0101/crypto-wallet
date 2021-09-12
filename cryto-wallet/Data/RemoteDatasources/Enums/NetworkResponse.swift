//
//  NetworkResponse.swift
//  cryto-wallet
//
//  Created by Hoang on 10/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
}
