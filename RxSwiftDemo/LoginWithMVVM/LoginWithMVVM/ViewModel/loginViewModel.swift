

//
//  loginViewModel.swift
//  LoginWithMVVM
//
//  Created by 叮咚钱包富银 on 2017/11/27.
//  Copyright © 2017年 leo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class loginViewModel {
    
    var nameUsable: Driver<Result>?
    var passwordUsable: Driver<Result>?
    var loginResult: Driver<Result>?
    
    init(name: Driver<String>, password: Driver<String>, tap: Driver<Void>) {
        
        let service = Service.shareInstance
        
        nameUsable = name.flatMapLatest({ (nameStr) in
            
            return service.loginUsernameValid(name: nameStr).asDriver(onErrorJustReturn: Result.error(message: "连接失败"))
        })
        
        let nameAndPassword = Driver.combineLatest(name, password) { ($0, $1) }
        
        passwordUsable = password.withLatestFrom(nameAndPassword).flatMapLatest({ (arg0)  in
            let (n, p) = arg0
            return service.loginPasswordValid(name: n, password: p).asDriver(onErrorJustReturn: Result.error(message: "连接失败"))
        })
        
        loginResult = tap.withLatestFrom(nameAndPassword).flatMapLatest({ (arg0) in
            let (n, p) = arg0
            return service.loginPasswordValid(name: n, password: p)
                .asDriver(onErrorJustReturn: Result.error(message: "连接失败"))

        })
        
    }
}
