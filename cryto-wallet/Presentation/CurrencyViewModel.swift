//
//  CurrencyViewModel.swift
//  cryto-wallet
//
//  Created by Hoang on 11/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

protocol CurrencyViewModelInput {
    func fetchCurrencies()
    func search(with text: String)
    func updateCurrency(_ entity: CurrencyEntity)
}

protocol CurrencyViewModelOutput {
    var currencies: Box<[CurrencyEntity]> { get }
    var favorites: Box<[CurrencyEntity]> { get }
}

protocol CurrencyViewModel: CurrencyViewModelInput, CurrencyViewModelOutput {}

final class DefaultCurrencyViewModel: CurrencyViewModel {
    var currencies: Box<[CurrencyEntity]> = Box([])
    var favorites: Box<[CurrencyEntity]> = Box([])
    
    private var datasource: [CurrencyEntity] = []
    private var searchText: String = ""

    private let currencyUsecase: CurrencyUsecase
    private let favoriteUseCase: FavoriteUseCase

    private var timer: Timer?

    init(with currencyUsecase: CurrencyUsecase, favoriteUseCase: FavoriteUseCase) {
        self.currencyUsecase = currencyUsecase
        self.favoriteUseCase = favoriteUseCase
        self.createTimer()
    }

    deinit {
        self.cancelTimer()
    }

    func createTimer() {
        if timer == nil {
            let timer = Timer(timeInterval: 30.0,
                              target: self,
                              selector: #selector(updateTimer),
                              userInfo: nil,
                              repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 1
            self.timer = timer
        }
    }

    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc func updateTimer() {
        self.fetchCurrencies()
    }

    private func updateFavorites(with datasource: [CurrencyEntity]) {
        let favorites = self.favoriteUseCase.favorites()
        let elements = Array(Set(datasource).intersection(Set(favorites)))
        self.favorites.value = elements
    }

    private func updateSelectedStates() {
        for item in self.favorites.value {
            var tmp = item
            tmp.setSelectedStatus(true)
            self.replaceEntityInSource(item: tmp)
        }
    }

    private func replaceEntityInSource(item: CurrencyEntity) {
        let index = self.currencies.value.firstIndex(of: item)
        if let index = index {
            self.currencies.value[index] = item
        }

        let currentIndex = self.datasource.firstIndex(of: item)
        if let currentIndex = currentIndex {
            self.datasource[currentIndex] = item
        }
    }

    private func filterCurrencies(with text: String) -> [CurrencyEntity] {
        let filtered = datasource.filter({item -> Bool in
            let stringMatch = item.name.lowercased().range(of: text.lowercased())
            return stringMatch != nil ? true : false
        })
        return filtered
    }

    private func updateCurrecies(from datasource: [CurrencyEntity]) {
        if (!searchText.isEmpty) {
            let filtered = self.filterCurrencies(with: searchText)
            self.currencies.value = filtered
        } else {
            self.currencies.value = datasource
        }
    }
}

// MARK: - Input
extension DefaultCurrencyViewModel {
    func fetchCurrencies() {
        self.currencyUsecase.fetchCurrencies {[weak self] response in
            guard let `self` = self else { return }
            switch (response) {
            case .success(let currencies) :
                self.datasource = currencies
                self.updateCurrecies(from: currencies)
                self.updateFavorites(with: self.datasource)
                self.updateSelectedStates()

            case .failure: break
            }
        }
    }

    func search(with text: String) {
        self.searchText = text
        if text.isEmpty {
            self.currencies.value = self.datasource
            return
        }
        let filtered = self.filterCurrencies(with: text)
        self.currencies.value = filtered
    }

    func updateCurrency(_ entity: CurrencyEntity) {
        var current = entity
        current.setSelectedStatus(!entity.isSelected)
        self.replaceEntityInSource(item: current)

        if current.isSelected {
            self.favoriteUseCase.save(entity: current)
        } else {
            self.favoriteUseCase.delete(entity: current)
        }

        self.updateFavorites(with: datasource)
    }
}
