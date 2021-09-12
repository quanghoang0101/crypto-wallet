//
//  Box.swift
//  cryto-wallet
//
//  Created by Hoang on 11/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import Foundation

final class Box<T> {
    var listener: ((T) -> Void)?

    var value: T {
        didSet { listener?(value) }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: ((T) -> Void)?) {
        self.listener = listener
        listener?(value)
    }
}
