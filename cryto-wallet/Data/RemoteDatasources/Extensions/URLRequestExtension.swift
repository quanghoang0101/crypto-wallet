//
//  URLRequestExtension.swift
//  cryto-wallet
//
//  Created by Hoang on 10/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

extension URLRequest {

    init(service: ServiceProtocol) {
        let urlComponents = URLComponents(service: service)

        self.init(url: urlComponents.url!)

        httpMethod = service.method.rawValue
        service.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }

        guard case let .requestParameters(parameters) = service.task, service.parametersEncoding == .json else { return }
        httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    }
}
