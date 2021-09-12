//
//  CurrencyModel.swift
//  cryto-wallet
//
//  Created by Hoang on 10/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

struct CurrenciesModel: Codable {
    let data: [CurrencyModel]?
}

struct CurrencyModel: Codable {
    let base: String?
    let counter: String?
    let buyPrice: String?
    let sellPrice: String?
    let icon: String?
    let name: String?

    enum CodingKeys : String, CodingKey {
        case base, counter, buyPrice = "buy_price", sellPrice = "sell_price", icon, name
    }
}

extension CurrencyModel {
    func toDomain() -> CurrencyEntity {
        return CurrencyEntity(
            base: self.base ?? "",
            counter: self.counter ?? "",
            buyPrice: Double(self.buyPrice ?? "0.0") ?? 0.0,
            sellPrice: Double(self.sellPrice ?? "0.0") ?? 0.0,
            icon: self.icon ?? "",
            name: self.name ?? ""
        )
    }
}
