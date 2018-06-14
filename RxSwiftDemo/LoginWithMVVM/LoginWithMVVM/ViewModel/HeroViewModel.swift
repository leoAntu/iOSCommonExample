
//
//  HeroViewModel.swift
//  LoginWithMVVM
//
//  Created by 叮咚钱包富银 on 2017/11/27.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HeroViewModel {

    var models:Driver<[Heros]>?
    
    init(seacherText: Observable<String>) {
        let service = HeroService.shareInstance
        
      models = seacherText.debug()
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .flatMapLatest({ text in
                return service.getHeros(withText: text)
        }).asDriver(onErrorJustReturn: [])
    }
    
}
