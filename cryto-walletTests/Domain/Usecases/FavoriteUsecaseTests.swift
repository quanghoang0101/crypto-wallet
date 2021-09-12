//
//  FavoriteUsecaseTests.swift
//  cryto-walletTests
//
//  Created by Hoang on 12/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import XCTest
import RealmSwift

@testable import cryto_wallet

class FavoriteUsecaseTests: XCTestCase {

    var favoriteUseCase: FavoriteUseCase!

    override func setUp() {
        super.setUp()

        var configuration = Realm.Configuration()
        configuration.inMemoryIdentifier = self.name

        let repository = RealmDatasource<CurrencyEntity>(configuration: configuration)
        favoriteUseCase = DefaultFavoriteUseCase(repository: repository)
    }

    override func tearDown() {
        self.favoriteUseCase = nil
        super.tearDown()
    }

    func testDatasourceShouldBeEmpty() {
        let entities = self.favoriteUseCase.favorites()
        XCTAssertTrue(entities.isEmpty)
    }

    func testSaveFavoriteItem() {
        let entity = CurrencyEntity(base: "base1", counter: "counter1", buyPrice: 0, sellPrice: 0, icon: "", name: "currency 1", isSelected: true)
        self.favoriteUseCase.save(entity: entity)

        let entities = self.favoriteUseCase.favorites()
        XCTAssertEqual(entities.count, 1)
    }

    func testDeleteFavoriteItem() {
        let entity = CurrencyEntity(base: "base1", counter: "counter1", buyPrice: 0, sellPrice: 0, icon: "", name: "currency 1", isSelected: true)
        self.favoriteUseCase.save(entity: entity)
        self.favoriteUseCase.delete(entity: entity)

        let entities = self.favoriteUseCase.favorites()
        XCTAssertTrue(entities.isEmpty)
    }
}
