//
//  UIView+Border.swift
//  cryto-wallet
//
//  Created by Hoang on 09/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import UIKit

extension UIView {

  var cornerRadius: CGFloat {

   get{
        return layer.cornerRadius
    }
    set {
        layer.cornerRadius = newValue
        layer.masksToBounds = newValue > 0
    }
  }

  var borderWidth: CGFloat {
    get {
        return layer.borderWidth
    }
    set {
        layer.borderWidth = newValue
    }
  }

  var borderColor: UIColor? {
    get {
        return UIColor(cgColor: layer.borderColor!)
    }
    set {
        layer.borderColor = newValue?.cgColor
    }
  }
}
