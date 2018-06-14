

//
//  Protocol.swift
//  LoginWithMVVM
//
//  Created by 叮咚钱包富银 on 2017/11/24.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum Result {
    case ok(message: String)
    case empty
    case error(message: String)
}

extension Result {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

extension Result {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case let .error(message):
            return message
        default:
            return ""
        }
    }
}

extension Result {
    var textColor: UIColor {
        switch self {
        case .ok:
            return UIColor.green
        default:
            return UIColor.red
        }
    }
}


extension Reactive where Base == UILabel {
    
    var validationResult: Binder<Result> {
        return Binder(base) { (label, result) in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}

extension Reactive where Base == UITextField {
    var isEnableInput: Binder<Result> {
        return Binder(base) { (textField, result) in
            textField.isEnabled = result.isValid
        }
    }
}

extension Reactive where Base == UIButton {
    var isEnableTap: Binder<Result> {
        return Binder(base) { (btn, result) in
            btn.isEnabled = result.isValid
        }
    }
}

