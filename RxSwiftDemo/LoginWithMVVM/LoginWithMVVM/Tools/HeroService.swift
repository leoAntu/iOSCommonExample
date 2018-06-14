//
//  HeroService.swift
//  LoginWithMVVM
//
//  Created by 叮咚钱包富银 on 2017/11/27.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HeroService {

    static let shareInstance = HeroService()
    private  init() { }
    
    private func getHeros() -> Observable<[Heros]>  {
        
        guard let path = Bundle.main.path(forResource: "heros", ofType: "plist"),
              let arr = NSArray(contentsOfFile: path) as? [[String: String]] else {
            return Observable.empty()
        }
        
        var heros = [Heros]()
        
        for dic in arr {
            let hero = Heros(name: dic["name"], desc: dic["intro"], icon: dic["icon"])
            heros.append(hero)
        }
       
        return Observable.just(heros)
        
    }
    
    func getHeros(withText text: String) -> Observable<[Heros]> {
        
        if text == "" {
            return getHeros()
        }
        
        guard let path = Bundle.main.path(forResource: "heros", ofType: "plist"),
            let arr = NSArray(contentsOfFile: path) as? [[String: String]] else {
                return Observable.empty()
        }
        
        var heros = [Heros]()
        
        for dic in arr {
            
            if ((dic["name"])?.contains(text))! {
                let hero = Heros(name: dic["name"], desc: dic["intro"], icon: dic["icon"]!)
                heros.append(hero)
            }
        }
        
        return Observable.just(heros)
    }
    
}
