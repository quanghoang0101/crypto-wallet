//
//  CurrencyEntity.swift
//  cryto-wallet
//
//  Created by Hoang on 11/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

struct CurrencyEntity: Equatable, Hashable {
    let base: String
    let counter: String
    var buyPrice: Double
    var sellPrice: Double
    let icon: String
    let name: String

    var isSelected: Bool = false

    mutating func setSelectedStatus(_ isSelected: Bool) {
        self.isSelected = isSelected
    }

    mutating func updatePrices(buyPrice: Double, sellPrice: Double) {
        self.buyPrice = buyPrice
        self.sellPrice = sellPrice
    }

    static func ==(lhs: CurrencyEntity, rhs: CurrencyEntity) -> Bool {
        return lhs.base == rhs.base
            && lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(base)
        hasher.combine(name)
    }
}
