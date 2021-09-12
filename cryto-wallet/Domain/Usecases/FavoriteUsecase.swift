//
//  FavoriteUsecase.swift
//  cryto-wallet
//
//  Created by Hoang on 12/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

protocol FavoriteUseCase {
    func favorites() -> [CurrencyEntity]
    func save(entity: CurrencyEntity) -> Void
    func delete(entity: CurrencyEntity)
}

final class DefaultFavoriteUseCase<Repository>: FavoriteUseCase where Repository: LocalDatasourceProtocol, Repository.T == CurrencyEntity {

    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }

    func favorites() -> [CurrencyEntity] {
        return repository.queryAll()
    }

    func save(entity: CurrencyEntity) -> Void {
        return repository.save(entity: entity)
    }

    func delete(entity: CurrencyEntity) -> Void {
        return repository.delete(entity: entity)
    }
}
