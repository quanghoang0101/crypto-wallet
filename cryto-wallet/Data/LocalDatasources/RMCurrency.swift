//
//  RMCurrency.swift
//  cryto-wallet
//
//  Created by Hoang on 11/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import RealmSwift

final class RMCurrency: Object {
    @objc dynamic var base: String = ""
    @objc dynamic var counter: String = ""
    @objc dynamic var icon: String = ""
    @objc dynamic var name: String = ""

    override class func primaryKey() -> String? {
        return "base"
    }
}

extension RMCurrency: DomainConvertibleType {
    func asDomain() -> CurrencyEntity {
        return CurrencyEntity(
            base: self.base ,
            counter: self.counter ,
            buyPrice: 0.0,
            sellPrice: 0.0,
            icon: self.icon,
            name: self.name,
            isSelected: true
        )
    }
}

extension CurrencyEntity: RealmRepresentable {
    func asRealm() -> RMCurrency {
        return RMCurrency.build { object in
            object.base = base
            object.counter = counter
            object.icon = icon
            object.name = name
        }
    }
}

extension Object {
    static func build<O: Object>(_ builder: (O) -> () ) -> O {
        let object = O()
        builder(object)
        return object
    }
}
