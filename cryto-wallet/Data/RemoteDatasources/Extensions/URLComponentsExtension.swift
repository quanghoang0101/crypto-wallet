//
//  URLComponentsExtension.swift
//  cryto-wallet
//
//  Created by Hoang on 10/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation
import RealmSwift

extension URLComponents {

    init(service: ServiceProtocol) {
        let url = service.baseURL.appendingPathComponent(service.path)
        self.init(url: url, resolvingAgainstBaseURL: false)!

        guard case let .requestParameters(parameters) = service.task, service.parametersEncoding == .url else { return }

        queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
