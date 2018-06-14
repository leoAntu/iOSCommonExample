
//
//  Service.swift
//  LoginWithMVVM
//
//  Created by 叮咚钱包富银 on 2017/11/24.
//  Copyright © 2017年 leo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

fileprivate let minLength = 6

class Service {
    
    static let shareInstance = Service()
    
    private init() {}
   
    /// 验证密码
    ///
    /// - Parameters:
    ///   - name: <#name description#>
    ///   - password: <#password description#>
    /// - Returns: <#return value description#>
    func loginPasswordValid(name: String, password: String) -> Observable<Result> {
        
        if name.count == 0 || password.count == 0 {
            return Observable.just(Result.error(message: "密码错误"))
        }
        
        if searchUsername(username: name) == false {
            return Observable.just(Result.error(message: "密码错误"))
        }
        
        if searchPassword(name: name, password: password) {
            return Observable.just(Result.ok(message: "密码正确"))
        }
        
        return Observable.just(Result.error(message: "密码错误"))
        
    }
    
    /// 验证用户名是否正确
    ///
    /// - Parameter name: <#name description#>
    /// - Returns: <#return value description#>
    func loginUsernameValid(name: String) -> Observable<Result> {
        
        if name.count == 0 {
            return Observable.just(Result.empty)
        }
        
        if searchUsername(username: name) {
            return Observable.just(Result.ok(message: "用户名存在"))
        }
        
        return Observable.just(Result.error(message: "用户名不存在"))
        
    }
    
    
    /// 注册用户
    ///
    /// - Parameters:
    ///   - name: <#name description#>
    ///   - password: <#password description#>
    /// - Returns: <#return value description#>
    func register(name: String, password: String) -> Observable<Result> {
        
        let dic = [name: password]
        
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        
        if (dic as NSDictionary).write(toFile: filePath, atomically: true) == true {
            return Observable.just(Result.ok(message: "注册成功"))
        }

        return Observable.just(Result.error(message: "注册失败"))
    }
    
    /// 两次密码比较
    ///
    /// - Parameters:
    ///   - password: <#password description#>
    ///   - repeatedPasswordword: <#repeatedPasswordword description#>
    /// - Returns: <#return value description#>
    func validateRepeatedPassword(password: String, repeatedPasswordword: String) -> Result {
        if repeatedPasswordword.count == 0 {
            return .empty
        }
        
        if repeatedPasswordword == password {
            return .ok(message: "密码可用")
        }
        
        return .error(message: "两次密码不一样")
    }
    
    /// 判断password是否有效
    ///
    /// - Parameter password: <#password description#>
    /// - Returns: <#return value description#>
    func validatePassword(password: String) -> Observable<Result> {
        
        if password.count == 0 {
            return Observable.just(Result.empty)
        }
        
        if password.count < minLength {
            return Observable.just(Result.error(message: "长度至少6个字符"))
        }
        
        return Observable.just(Result.ok(message: "密码可用"))
    }
    
    /// 判断username是否有效
    ///
    /// - Parameter username: <#username description#>
    /// - Returns: <#return value description#>
    func validateUsername(username: String) ->Observable<Result> {
        
        if username.count == 0 {
            return Observable.just(Result.empty)
        }
        
        if username.count < minLength {
            return Observable.just(Result.error(message: "长度至少6个字符"))
        }
        
        
        if searchUsername(username: username) == false {
            return Observable.just(Result.ok(message: "用户名可用"))
        }
        
        return Observable.just(Result.error(message: "用户名已存在"))
    }
    

    
    /// 查找username是否存在
    ///
    /// - Parameter username: <#username description#>
    /// - Returns: <#return value description#>
    func searchUsername(username: String) -> Bool {
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        print(filePath)
        
        guard let dict = NSDictionary(contentsOfFile: filePath),
            let usernameArr = dict.allKeys as? [String]   else {
            return false
        }
        
       return (usernameArr as NSArray).contains(username)

    }
    
    /// 查找密码
    ///
    /// - Parameters:
    ///   - name: <#name description#>
    ///   - password: <#password description#>
    /// - Returns: <#return value description#>
    func searchPassword(name: String, password: String) -> Bool {
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        print(filePath)

        guard let dict = NSDictionary(contentsOfFile: filePath) else {
                return false
        }
        
        let tmpStr = dict[name] as? String
        
        if password == tmpStr {
            return true
        }
        
        return false
    }
}
