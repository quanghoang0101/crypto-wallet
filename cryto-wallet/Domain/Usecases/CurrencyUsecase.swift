//
//  CurrencyUsecase.swift
//  cryto-wallet
//
//  Created by Hoang on 11/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

protocol CurrencyUsecase {
    func fetchCurrencies(comletion: @escaping (Result<[CurrencyEntity], Error>) -> Void)
}

final class DefaultCurrencyUsecase: CurrencyUsecase {

    private let currencyRepository: CurrencyRepository

    init(currencyRepository: CurrencyRepository) {
        self.currencyRepository = currencyRepository
    }
    
    func fetchCurrencies(comletion: @escaping (Result<[CurrencyEntity], Error>) -> Void){
        return self.currencyRepository.fetchCurrencies(comletion: comletion)
    }
}
