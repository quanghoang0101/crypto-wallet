//
//  RealmRepresentable.swift
//  cryto-wallet
//
//  Created by Hoang on 12/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

protocol RealmRepresentable {
    associatedtype RealmType: DomainConvertibleType

    var base: String {get}

    func asRealm() -> RealmType
}
