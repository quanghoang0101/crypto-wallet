//
//  CurrencyViewModel.swift
//  cryto-walletTests
//
//  Created by Hoang on 12/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import XCTest
@testable import cryto_wallet

class CurrencyViewModelTests: XCTestCase {

    var viewModel: CurrencyViewModel!
    var mockCurrencyUsecase: CurrencyUsecase!
    var mockFavoriteUseCase: FavoriteUseCase!

    override func setUp() {
        super.setUp()
        self.mockCurrencyUsecase = MockCurrencyUsecase()
        self.mockFavoriteUseCase = MockFavoriteUseCase()
        self.viewModel = DefaultCurrencyViewModel(with: mockCurrencyUsecase, favoriteUseCase: mockFavoriteUseCase)
    }

    override func tearDown() {
        self.mockCurrencyUsecase = nil
        self.mockFavoriteUseCase = nil
        self.viewModel = nil
        super.tearDown()
    }

    func testToFetchCurrencies() {
        let expectation = self.expectation(description: "Fetch currencies")

        self.viewModel.fetchCurrencies()
        expectation.fulfill()

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertEqual(self.viewModel.currencies.value.count, 5)
        XCTAssertEqual(self.viewModel.favorites.value.count, 2)
    }

    func testToSearchCurrencies() {
        let expectation = self.expectation(description: "Search currencies")

        self.viewModel.fetchCurrencies()
        self.viewModel.search(with: "currency 1")
        expectation.fulfill()

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertEqual(self.viewModel.currencies.value.count, 1)
    }

    func testToSearchCurrenciesWithEmptyString() {
        let expectation = self.expectation(description: "Search currencies with empty string")

        self.viewModel.fetchCurrencies()
        self.viewModel.search(with: "")
        expectation.fulfill()

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertEqual(self.viewModel.currencies.value.count, 5)
    }

    func testFavoriteCurrency() {
        let expectation = self.expectation(description: "Favorite currency")

        self.viewModel.fetchCurrencies()
        let entity = self.viewModel.currencies.value.last!
        self.viewModel.updateCurrency(entity)
        expectation.fulfill()

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertEqual(self.viewModel.currencies.value.last?.isSelected, true)
    }

    func testUnfavoriteCurrency() {
        let expectation = self.expectation(description: "Unfavorite currency")

        self.viewModel.fetchCurrencies()
        // Favorite
        var entity = self.viewModel.currencies.value.last!
        self.viewModel.updateCurrency(entity)
        
        // Unfavorite
        entity = self.viewModel.currencies.value.last!
        self.viewModel.updateCurrency(entity)

        expectation.fulfill()

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertEqual(self.viewModel.currencies.value.last?.isSelected, false)
    }

}

class MockCurrencyUsecase: CurrencyUsecase {
    func fetchCurrencies(comletion: @escaping (Result<[CurrencyEntity], Error>) -> Void) {
        comletion(.success(MockCurrency.createMockCurrencies()))
    }
}

class MockFavoriteUseCase: FavoriteUseCase {
    func favorites() -> [CurrencyEntity] {
        return [
            CurrencyEntity(base: "base1", counter: "counter1", buyPrice: 0, sellPrice: 0, icon: "", name: "currency 1", isSelected: true),
            CurrencyEntity(base: "base2", counter: "counter2", buyPrice: 0, sellPrice: 0, icon: "", name: "currency 2", isSelected: true),
        ]
    }

    func save(entity: CurrencyEntity) {}

    func delete(entity: CurrencyEntity) {}
}
