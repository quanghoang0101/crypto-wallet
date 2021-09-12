//
//  CurrencyRepositoryImpl.swift
//  cryto-wallet
//
//  Created by Hoang on 11/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

final class CurrencyRepositoryImpl: CurrencyRepository {

    private let sessionProvider: ProviderProtocol

    init(sessionProvider: ProviderProtocol) {
        self.sessionProvider = sessionProvider
    }

    func fetchCurrencies(comletion: @escaping (Result<[CurrencyEntity], Error>) -> Void) {
        self.sessionProvider.request(type: CurrenciesModel.self, service: CurrrencyService.allCurrencies) { response in
            switch response {
            case let .success(currencies):
                let models = currencies.data ?? []
                let toDomain = models.map { $0.toDomain() }
                comletion(.success(toDomain))
            case let .failure(error):
                comletion(.failure(error))
            }
        }
    }
}
