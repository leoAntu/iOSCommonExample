//
//  LoginViewController.swift
//  LoginWithMVVM
//
//  Created by 叮咚钱包富银 on 2017/11/24.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var rightBarBtn: UIBarButtonItem!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var passwordLab: UILabel!
    @IBAction func rightBtnAction(_ sender: Any) {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewModel = loginViewModel(name: nameTextFiled.rx.text.orEmpty.asDriver(),
                                       password: passwordTextField.rx.text.orEmpty.asDriver(), tap: loginBtn.rx.tap.asDriver())
        
        viewModel.nameUsable?
            .drive(nameLab.rx.validationResult)
            .disposed(by: dispose)
      
        
        viewModel.passwordUsable?
            .drive(passwordLab.rx.validationResult)
            .disposed(by: dispose)
        
        viewModel.loginResult?.drive(onNext: { [weak self] (result) in
            switch result {
            case .ok:
                self?.navigationController?.pushViewController(TableViewController(), animated: true)
            case .empty:
                return
            case let .error(message):
                self?.showAlert(message: message)
            }
            
        })
        .disposed(by: dispose)
        
    }

    func showAlert(message: String) {
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertViewController.addAction(action)
        present(alertViewController, animated: true, completion: nil)
    }
}
