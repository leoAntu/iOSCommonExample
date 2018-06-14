

//
//  RegisterViewModel.swift
//  LoginWithMVVM
//
//  Created by 叮咚钱包富银 on 2017/11/24.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class RegisterViewModel {

    var name = Variable("")
    var password = Variable("")
    var repeatPassword = Variable("")
    //接受点击手势，Variable必须需要初始值，所有使用PublishSubject
    var registerTap = PublishSubject<Void>()
    
    //结果处理值
    var nameUsable: Observable<Result>?
    var passwordUsable: Observable<Result>?
    var repeatUsable: Observable<Result>?
    var registerResult: Observable<Result>?

    
    init() {
        
        let service = Service.shareInstance
        
        nameUsable = name.asObservable().flatMapLatest({ (username) in
            return service.validateUsername(username: username)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(Result.error(message: "name检测出错"))
        }).share(replay: 1)
        
        passwordUsable = password.asObservable().flatMapLatest({ (password) -> Observable<Result> in
            return service.validatePassword(password: password)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(Result.error(message: "password检测出错"))
        }).share(replay: 1)
        
        //RegisterViewController中必须订阅repeatUsable 才会执行里面的方法
        repeatUsable =  Observable.combineLatest(password.asObservable(), repeatPassword.asObservable()) { (a, b) -> Result in
            return service.validateRepeatedPassword(password: a, repeatedPasswordword: b)
        }.share(replay: 1)

        let nameAndPassword = Observable.combineLatest(name.asObservable(), password.asObservable()) { ($0, $1)}
        
        //flatMapLatest 获取最新的数据
        registerResult = registerTap.asObserver().withLatestFrom(nameAndPassword).flatMapLatest({ (nameStr, passwordStr) in
            
                return service.register(name: nameStr, password: passwordStr)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(Result.error(message: "注册失败"))
            
        })
            .share(replay: 1)
        
    }

}
