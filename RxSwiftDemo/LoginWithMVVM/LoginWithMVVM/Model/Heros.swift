//
//  Heros.swift
//  LoginWithMVVM
//
//  Created by 叮咚钱包富银 on 2017/11/27.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit

class Heros: NSObject {
    var name: String?
    var desc: String?
    var icon: String?
    
    init(name: String?, desc: String?, icon: String?) {
        self.name = name
        self.desc = desc
        self.icon = icon
    }
    
    
}
