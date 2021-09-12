//
//  CurrencyRepository.swift
//  cryto-wallet
//
//  Created by Hoang on 11/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

protocol CurrencyRepository {
    func fetchCurrencies(comletion: @escaping (Result<[CurrencyEntity], Error>) -> Void)
}
