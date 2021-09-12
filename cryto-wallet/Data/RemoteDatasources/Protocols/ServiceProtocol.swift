//
//  ServiceProtocol.swift
//  cryto-wallet
//
//  Created by Hoang on 10/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

typealias Headers = [String: String]

protocol ServiceProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}

extension ServiceProtocol {
    var baseURL: URL {
        return URL(string: "https://www.coinhako.com")!
    }
}
