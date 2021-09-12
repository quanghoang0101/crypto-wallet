//
//  RealmDatasource.swift
//  cryto-wallet
//
//  Created by Hoang on 11/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

protocol LocalDatasourceProtocol {
    associatedtype T
    func queryAll() -> [T]
    func save(entity: T) -> Void
    func delete(entity: T) -> Void
}

final class RealmDatasource<T: RealmRepresentable>: LocalDatasourceProtocol where T == T.RealmType.DomainType, T.RealmType: Object {

    private let configuration: Realm.Configuration

    private var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }

    init(configuration: Realm.Configuration) {
        self.configuration = configuration
        print("File 📁 url: \(RLMRealmPathForFile("default.realm"))")
    }

    func queryAll() -> [T] {
        let realm = self.realm
        let objects = realm.objects(T.RealmType.self)
        return Array(objects).mapToDomain()
    }

    func save(entity: T) {
        try? realm.save(entity: entity)
    }

    func delete(entity: T) {
        try? realm.delete(entity: entity)
    }
}

extension Sequence where Iterator.Element: DomainConvertibleType {
    typealias Element = Iterator.Element
    func mapToDomain() -> [Element.DomainType] {
        return map {
            return $0.asDomain()
        }
    }
}

extension Realm {
    func save<R: RealmRepresentable>(entity: R, update: UpdatePolicy = .all) throws -> Void where R.RealmType: Object  {
        do {
            try self.write {
                self.add(entity.asRealm(), update: update)
            }
        } catch {
            throw error
        }
    }

    func delete<R: RealmRepresentable>(entity: R) throws -> Void where R.RealmType: Object  {
        do {
            guard let object = self.object(ofType: R.RealmType.self, forPrimaryKey: entity.base) else { fatalError() }

            try self.write {
                self.delete(object)
            }
        } catch {
            throw error
        }
    }
}
