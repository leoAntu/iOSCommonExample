//
//  TableViewController.swift
//  LoginWithMVVM
//
//  Created by 叮咚钱包富银 on 2017/11/27.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = HeroViewModel(seacherText: searchBar.rx.text.orEmpty
            .throttle(1, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        )
        
        tableView .register(UITableViewCell.self, forCellReuseIdentifier: "cell");
        
        viewModel.models?
            .drive(tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element.name
                cell.detailTextLabel?.text = element.desc
                cell.imageView?.image = UIImage(named: element.icon ?? "")
            }
            .disposed(by: dispose)
    }


}
