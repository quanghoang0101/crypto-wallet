//
//  UsecaseProvider.swift
//  cryto-wallet
//
//  Created by Hoang on 11/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation
import RealmSwift

protocol UseCaseProvider {
    func makeCurrencyUsecase() -> CurrencyUsecase
    func makeFavoriteUseCase() -> FavoriteUseCase
}

final class DefaultUseCaseProvider: UseCaseProvider {
    private let sessionProvider: URLSessionProvider
    private let configuration: Realm.Configuration

    init(session: URLSessionProtocol = URLSession.shared,
         configuration: Realm.Configuration = Realm.Configuration()
    ) {
        self.sessionProvider = URLSessionProvider(session: session)
        self.configuration = configuration
    }

    func makeCurrencyRepository() -> CurrencyRepository {
        return CurrencyRepositoryImpl(sessionProvider: sessionProvider)
    }

    func makeCurrencyUsecase() -> CurrencyUsecase {
        let usecase = DefaultCurrencyUsecase(currencyRepository: self.makeCurrencyRepository())
        return usecase
    }

    func makeFavoriteUseCase() -> FavoriteUseCase {
        let repository = RealmDatasource<CurrencyEntity>(configuration: configuration)
        return DefaultFavoriteUseCase(repository: repository)
    }
}
