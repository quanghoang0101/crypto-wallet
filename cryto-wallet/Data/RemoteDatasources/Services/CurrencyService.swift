//
//  CurrencyService.swift
//  cryto-wallet
//
//  Created by Hoang on 11/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

enum CurrrencyService: ServiceProtocol {

    case allCurrencies

    var path: String {
        switch self {
        case .allCurrencies:
            return "/api/v3/price/all_prices_for_mobile"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var task: Task {
        switch self {
        case .allCurrencies:
            let parameters = ["counter_currency": "USD"]
            return .requestParameters(parameters)
        }
    }

    var headers: Headers? {
        return nil
    }

    var parametersEncoding: ParametersEncoding {
        return .url
    }
}
