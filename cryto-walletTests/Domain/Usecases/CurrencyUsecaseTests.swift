//
//  CurrencyUsecaseTests.swift
//  cryto-walletTests
//
//  Created by Hoang on 12/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import XCTest
@testable import cryto_wallet

class CurrencyUsecaseTests: XCTestCase {

    var currencyRepository: MockCurrencyRepository!
    var currencyUsecase: CurrencyUsecase!

    override func setUp() {
        super.setUp()
        self.currencyRepository = MockCurrencyRepository()
        self.currencyUsecase = DefaultCurrencyUsecase(currencyRepository: currencyRepository)
    }

    override func tearDown() {
        self.currencyRepository = nil
        self.currencyUsecase = nil
        super.tearDown()
    }

    func testToFetchCurrencies() {
        let expectation = self.expectation(description: "Fetch currencies")

        var currencies: [CurrencyEntity] = []
        self.currencyUsecase.fetchCurrencies { response in
            switch response {
            case .success(let result): currencies = result
            case .failure: currencies = []
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertEqual(currencies.count, 5)
    }
    
}

class MockCurrencyRepository: CurrencyRepository {
    func fetchCurrencies(comletion: @escaping (Result<[CurrencyEntity], Error>) -> Void) {
        comletion(.success(MockCurrency.createMockCurrencies()))
    }
}
