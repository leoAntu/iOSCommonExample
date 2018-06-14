//
//  ViewController.swift
//  LoginDemo
//
//  Created by 叮咚钱包富银 on 2017/11/23.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


fileprivate let minUsernameLength = 5
fileprivate let minPasswordLength = 5

class ViewController: UIViewController {
    @IBOutlet weak var userNameTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userNameValidLab: UILabel!
    @IBOutlet weak var passwordValidLab: UILabel!
    
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        userNameValidLab.text = "Username has to be at least \(minUsernameLength) characters"
        passwordValidLab.text = "Password has to be at least \(minPasswordLength) characters"

        /// 创建三个Observer对象 接受sequence
        let usernameSequence = userNameTextFiled.rx.text.orEmpty
            .map { (str) -> Bool in
                return str.count >= minUsernameLength
            }
            .share(replay: 1) //能够减少map的计算

        let passwordSequence = passwordTextFiled.rx.text.orEmpty
            .map { (str) -> Bool in
                return str.count >= minPasswordLength
            }
            .share(replay: 1)

        let everythingSequence = Observable.combineLatest(usernameSequence, passwordSequence) { (a, b) -> Bool in
                print(a,b)
                return a && b
            }
            .share(replay: 1)

        //监听usernameSequence 事件
        usernameSequence
            .bind(to: passwordTextFiled.rx.isEnabled)
            .disposed(by: dispose)
        usernameSequence
            .bind(to: userNameValidLab.rx.isHidden)
            .disposed(by: dispose)

        //监听passwordSequence 事件
        passwordSequence
            .bind(to: passwordValidLab.rx.isHidden)
            .disposed(by: dispose)

        //监听everythingSequence 事件
        everythingSequence
            .bind(to: loginBtn.rx.isEnabled)
            .disposed(by: dispose)

     // 监听loginBtn 点击事件
        loginBtn.rx.tap.subscribe { [weak self] (_) in
            self?.showAlert()
        }.disposed(by: dispose)
        
        


    }
    
    private func showAlert() {
        let alertView = UIAlertView(title: "登录", message: "恭喜成功", delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

