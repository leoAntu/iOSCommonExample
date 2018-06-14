//
//  RegisterViewController.swift
//  LoginWithMVVM
//
//  Created by 叮咚钱包富银 on 2017/11/24.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RegisterViewController: UIViewController {
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var passwordLab: UILabel!
    @IBOutlet weak var repeatLab: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup(){
        
        let viewModel = RegisterViewModel()
        
        nameField.rx.text.orEmpty.bind(to: viewModel.name).disposed(by: dispose)
        passwordField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: dispose)
        repeatField.rx.text.orEmpty.bind(to: viewModel.repeatPassword).disposed(by: dispose)
        registerBtn.rx.tap.bind(to: viewModel.registerTap).disposed(by: dispose)
        
        //两个方法实现功能一样，下面方法扩展的更好，所有的lab都能使用此方法
        //        viewModel.nameUsable?.subscribe(onNext: { [weak self] (result) in
        //            self?.setNameLab(result: result)
        //        }).disposed(by: dispose)
        viewModel.nameUsable?
            .bind(to: nameLab.rx.validationResult)
            .disposed(by: dispose)
        viewModel.nameUsable?.bind(to: passwordField.rx.isEnableInput).disposed(by: dispose)

        viewModel.passwordUsable?
            .bind(to: passwordLab.rx.validationResult)
            .disposed(by: dispose)
        viewModel.passwordUsable?.bind(to: repeatField.rx.isEnableInput).disposed(by: dispose)
        
        viewModel.repeatUsable?.bind(to: repeatLab.rx.validationResult).disposed(by: dispose)
        viewModel.repeatUsable?.bind(to: registerBtn.rx.isEnableTap).disposed(by: dispose)
    
        viewModel.registerResult?.subscribe(onNext: { [weak self] (result) in
            switch result {
            case let .ok(message):
                self?.showAlert(message: message)
            case .empty:
                self?.showAlert(message: "")
            case let .error(message):
                self?.showAlert(message: message)
            }
            
        }).disposed(by: dispose)
    }
    
    
    func showAlert(message: String) {
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertViewController.addAction(action)
        present(alertViewController, animated: true, completion: nil)
    }
}

private extension RegisterViewController {
    private func setNameLab(result: Result) {
        print(result)
        nameLab.text = result.description
        nameLab.textColor = result.textColor
    }
}
