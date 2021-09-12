//
//  MockCurrencies.swift
//  cryto-walletTests
//
//  Created by Hoang on 12/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation
@testable import cryto_wallet

class MockCurrency {

    static func createMockCurrencies() -> [CurrencyEntity] {
        return [
            CurrencyEntity(base: "base1", counter: "counter1", buyPrice: 10, sellPrice: 10, icon: "", name: "currency 1"),
            CurrencyEntity(base: "base2", counter: "counter2", buyPrice: 10, sellPrice: 10, icon: "", name: "currency 2"),
            CurrencyEntity(base: "base3", counter: "counter3", buyPrice: 10, sellPrice: 10, icon: "", name: "currency 3"),
            CurrencyEntity(base: "base4", counter: "counter4", buyPrice: 10, sellPrice: 10, icon: "", name: "currency 4"),
            CurrencyEntity(base: "base5", counter: "counter5", buyPrice: 10, sellPrice: 10, icon: "", name: "currency 5"),
        ]
    }
}
