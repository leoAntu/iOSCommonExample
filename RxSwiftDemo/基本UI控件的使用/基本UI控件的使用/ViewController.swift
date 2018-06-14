//
//  ViewController.swift
//  基本UI控件的使用
//
//  Created by 叮咚钱包富银 on 2017/11/24.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var panGestureLab: UILabel!
   
    let dispose = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldTest()
        segmentControlTest()
        buttonTest()
        switchAndActivityViewTest()
        sliderTest()
        datePickerTest()
        panGestureTest()
    }
    
    func panGestureTest() {
        
        let pan = UITapGestureRecognizer()
        panGestureLab.addGestureRecognizer(pan)
        
        pan.rx.event.subscribe(onNext: { [weak self] (ges) in
            print(ges)
            self?.showAlert()
        }).disposed(by: dispose)
        
    }
    
    func datePickerTest() {
        
        let dateValue = Variable(Date.init(timeIntervalSinceNow: 0))
        
        _ = datePicker.rx.date <-> dateValue
        
        dateValue.asObservable()
            .subscribe(onNext: { (date) in
                print(date)
            })
            .disposed(by: dispose)
    }
    
    func sliderTest() {
        
        let sliderValue = Variable<Float>(0.1)
        
        _ = slider.rx.value <-> sliderValue
        
        sliderValue.asObservable().subscribe(onNext: { (e) in
            print(e)
        }).disposed(by: dispose)
    }
    
    func switchAndActivityViewTest() {
        
        let switchValue = Variable(true)
        
        _ = switcher.rx.value <-> switchValue
        
        switchValue
            .asObservable()
            .bind(to: activityView.rx.isAnimating)
            .disposed(by: dispose)
    }

    func buttonTest() {
        //两种点击事件
        
//        button.rx.controlEvent([.touchUpInside]).subscribe(onNext: {[weak self] (e) in
//            self?.showAlert()
//        }).disposed(by: dispose)
    
        button.rx.tap
            .subscribe(onNext: {[weak self] (e) in
                self?.showAlert()
            })
            .disposed(by: dispose)
        
    }
    
    func segmentControlTest() {
        
        let segmentValue = Variable(0)
        _ = segmentControl.rx.value <-> segmentValue
        
        segmentValue.asObservable()
            .subscribe(onNext: { (e) in
                print(e)
            })
            .disposed(by: dispose)
        
    }
    
    func textFieldTest() {
        // 单向绑定值,将textField的值绑定到textValue
        let textValue = Variable("")
        _ = textField.rx.textInput <-> textValue
        
        textValue.asObservable()
            .subscribe(onNext: { x in
                print(x)
            })
            .disposed(by: dispose)
        
        //单个UITextField事件监听,进入编辑的时候监听
        textField.rx.controlEvent([.editingDidBegin])
            .subscribe(onNext: { (e) in
                print(e)
            }).disposed(by: dispose)
        
        
    }
    
    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

