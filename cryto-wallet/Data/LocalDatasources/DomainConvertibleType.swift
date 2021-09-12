//
//  DomainConvertibleType.swift
//  cryto-wallet
//
//  Created by Hoang on 12/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype DomainType

    func asDomain() -> DomainType
}
