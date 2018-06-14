//
//  ViewController.swift
//  Demo
//
//  Created by 叮咚钱包富银 on 2017/11/21.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    
    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    //必须放外面，要不然释放后，combineLatest就不再执行
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        toArrayTest()
    }
    
//MARK ---  算数和聚合(Mathematical and Aggregate Operators)
    
//    toArray 将sequence转换成一个array，并转换成单一事件信号，然后结束
//    next([1, 2, 3, 4, 5])
//    completed
    func toArrayTest() {
        Observable.of(1,2,3,4,5).toArray().subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
    }
//    reduce 用一个初始值，对事件数据进行累计操作。reduce接受一个初始值，和一个操作符号
//    next(15)
//    completed
    func reduceTest() {
        Observable.of(1,2,3,4,5).reduce(0, accumulator: +).subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
    }
//
//    concat
//    合并两个或者以上的 Observable 的消息，并且这些消息的发送时间不会交叉。（队列先后顺序不会交叉）
//    next(0)
//    next(1)
//    next(2)
//    next(3)
//    next(201)
//    next(202)
    func concatTest() {
        let var1 = BehaviorSubject(value: 0)
        let var2 = BehaviorSubject(value: 200)
        
        // 类型为BehaviorSubject<BehaviorSubject<Int>>
        let var3 = BehaviorSubject(value: var1)
        
        var3.concat().subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
        
        var1.onNext(1)
        var1.onNext(2)
        
        var3.onNext(var2)
        var2.onNext(201)
        
        var1.onNext(3)
        
        var1.onCompleted()  //必须调用 onCompleted 才会执行var2
        
        var2.onNext(202)
    }


    
//MARK :条件和布尔操作（Conditional and Boolean Operators）
    
//    takeWhile 发送原始 Observable 的数据，直到一个特定的条件为 false
//    next(1)
//    next(2)
//    completed
    func takeWhileTest() {
        let sequence = PublishSubject<Int>()
        
        sequence.takeWhile { (i) -> Bool in
            return i < 4
            }.subscribe { (e) in
                print(e)
        }.disposed(by: disposeBag)
        
        sequence.onNext(1)
        sequence.onNext(2)
        
        sequence.onNext(5)
    }
//    takeUntil
//    当第二个 Observable 发送数据之后，丢弃第一个 Observable 在这之后的所有消息。
//    next(1)
//    next(2)
//    completed
    func takeUntilTest() {
        let originalSequence = PublishSubject<Int>()
        let whenThisSendsNextWorldStops = PublishSubject<Int>()
        
        originalSequence.takeUntil(whenThisSendsNextWorldStops)
            .subscribe { (e) in
                print(e)
        }.disposed(by: disposeBag)
        
        originalSequence.onNext(1)
        originalSequence.onNext(2)
        
        whenThisSendsNextWorldStops.onNext(3)
        
        originalSequence.onNext(4)

    }
    
    
//MARK -Observable Utility Operators
    
//    doOn
//    注册一个操作来监听事件的生命周期 此操作在调用subscribe 前调用，可以做一些其他的操作
    func doOnTest() {
        
//        onSubscribe
//        onSubscribed
//        sdfsf
//        next(1)
        
        let sequenceOfInts = PublishSubject<Int>()
        sequenceOfInts.do(onNext: { (e) in
            print("sdfsf")
        }, onError: nil, onCompleted: nil, onSubscribe: {
            print("onSubscribe")
        }, onSubscribed: {
            print("onSubscribed")
        }, onDispose: nil)
        .subscribe { (e) in
            print(e)
        }
        .disposed(by: disposeBag)

        sequenceOfInts.onNext(1)
        
    
//         运行结果
//        onSubscribe
//        onSubscribed
//        Disposed

//        let observable = Observable<Any>.never()
//
//        let disposeBag = DisposeBag()
//
//        observable
//            .do(onNext: { (e) in
//                print("werwerwer") //不会执行
//            }, onSubscribe: {
//                print("onSubscribe")
//            }, onSubscribed: {
//                print("onSubscribed")
//            }, onDispose: nil)
//            .subscribe(
//                onNext: { element in   //不会执行
//                    print(element)
//            },
//                onCompleted: {
//                    print("Completed")  //不会执行
//            },
//                onDisposed: {
//                    print("Disposed")
//            }
//            )
//            .addDisposableTo(disposeBag)
    }
    
    
    func subscribeTest() {
        let sequenceOfInts = PublishSubject<Int>()
        
//        输出结果
//        next(1)
//        completed
        
//        sequenceOfInts.subscribe { (e) in
//            print(e)
//        }.disposed(by: disposeBag)
//
//        sequenceOfInts.onNext(1)
//        sequenceOfInts.onCompleted()
        
        
//        //        输出结果
//        //1
        sequenceOfInts.subscribe(onNext: { (e) in
            print(e)
        }).disposed(by: disposeBag)
        sequenceOfInts.onNext(1)
        sequenceOfInts.onCompleted()


    }
    
//MARK --- 错误处理
    
//    retry
//    如果原始 Observable 遇到错误，重新订阅，心里默念，不会出错不会出错...
//    next(1)
//    next(2)
//    next(1)
//    next(2)
//    next(3)
//    next(4)
    func retryTest() {
        var count = 1
        let sequence = Observable<Int>.create { (observer) -> Disposable in
            let err = NSError(domain: "Test", code: -1, userInfo: nil)
            observer.onNext(1)
            observer.onNext(2)
            if count < 2 {
                observer.onError(err)
                count = count + 1
            }
            
            observer.onNext(3)
            observer.onNext(4)
            
            return Disposables.create()
        }
        
        sequence.retry().subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
    }
//    catchError捕获error进行处理，可以返回另一个sequence进行订阅
//    next(1)
//    next(2)
//    next(100)
//    completed
    func catchErrorTest2() {
        let sequenceThatFails = PublishSubject<Int>()
        
        sequenceThatFails.catchErrorJustReturn(100).subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
        
        sequenceThatFails.onNext(1)
        sequenceThatFails.onNext(2)
        
        sequenceThatFails.onError(NSError(domain: "TEST", code: -1, userInfo: nil))
    }
    
//    next(1)
//    next(2)
//    next(100)
//    next(200)
//    next(300)
//    next(400)
//    completed
    
    func catchErrorTest() {
        let sequenceThatFails = PublishSubject<Int>()
        let recoverySequence = Observable.of(100, 200, 300, 400)
        
        sequenceThatFails.catchError { (err) -> Observable<Int> in
            return recoverySequence
            }.subscribe { (e) in
                print(e)
        }.disposed(by: disposeBag)
        
        sequenceThatFails.onNext(1)
        sequenceThatFails.onNext(2)
        sequenceThatFails.onError(NSError(domain: "TEST", code: -1, userInfo: nil))

    }
    
    
//MARK -- 结合操作(Combination operators)
    
//    switchLatest可以对事件流进行转换，本来监听的subject1，我可以通过更改variable里面的value更换事件源。变成监听subject2了
//    next(0)
//    next(1)
//    next(2)
//    next(200)
//    next(3)
//    completed
    func switchLatestTest() {
        let var1 = Variable(0)
        
        let var2 = Variable(200)
        
        // var3 is like an Observable<Observable<Int>>
        let var3 = Variable(var1.asObservable())
        
        var3.asObservable().switchLatest().subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
      

        var1.value = 1
        var1.value = 2
        
        var3.value = var2.asObservable()  //切换了监听源
        
        var2.value = 3
        var1.value = 4
    }

//    merge
//    合并多个 Observables 的组合成一个
//    next(1)
//    next(2)
//    next(3)
//    next(4)
    func mergeTest() {
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        Observable.of(subject1, subject2).merge().subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
        
        subject1.onNext(1)
        subject1.onNext(2)
        subject2.on(.next(3))
        subject1.onNext(4)
    }
    
//    next(2 0)
//    completed
    func zipTest2() {
        let intOb1 = Observable.just(2)
        let intOb2 = Observable.of(0, 1, 2, 3, 4)
        Observable.zip(intOb1, intOb2) { (a, b) in
            return "\(a) \(b)"
            }
            .subscribe { (e) in
                print(e)
            }
            .disposed(by: disposeBag)
    }
    
//    zip
//    绑定超过最多不超过8个的Observable流，结合在一起处理。注意Zip是一个事件对应另一个流一个事件。 类似一一对应
//    next(a 1)
//    next(b 2)
    func zipTest() {
        let intOb1 = PublishSubject<String>()
        let intOb2 = PublishSubject<Int>()
        
        Observable.zip(intOb1, intOb2) { (a, b) in
                return "\(a) \(b)"
            }
            .subscribe { (e) in
                print(e)
            }
            .disposed(by: disposeBag)

        
        intOb1.onNext("a")
        intOb2.onNext(1)
        
        intOb1.onNext("b")
        intOb2.onNext(2)
    }

//    combineLatest 为了能够产生结果，两个序列中都必须保证至少有一个元素
//    next(0)
//    next(2)
//    next(4)
//    next(6)
//    next(8)
//    completed
    func combineLatestTest2() {
        let intOb1 = Observable.just(2)
        let intOb2 = Observable.of(0, 1, 2, 3, 4)
        
        Observable.combineLatest(intOb1, intOb2) { (a, b) in
            return a * b
            }.subscribe { (e) in
                print(e)
        }.disposed(by: disposeBag)
    
    }
    
//   combineLatest 将多个 Observable 结合成一个 Observable
//    next(2 b)
//    next(3 b)
//    next(3 c)
    func combineLatestTest() {
        let s1 = PublishSubject<Int>()
        let s2 = PublishSubject<String>()

        Observable.combineLatest(s1, s2) { (a, b) in
            return "\(a) \(b)"
            }
            .subscribe { (e) in
                print(e)
        }
            .disposed(by: disposeBag)

        s1.onNext(1)  // 初始状态只改变过一个值（PublishSubject导致），是不会执行combineLatest
        s1.onNext(2)
        s2.onNext("b")

        s1.onNext(3)

        s2.onNext("c")
        
    }
    
    //    startWith在数据序列的开头增加一些数据
    //    next(7)
    //    next(0)
    //    next(3)
    //    next(4)
    //    next(5)
    //    next(6)
    //    completed
    func startWithTest() {
        Observable.of(3, 4, 5, 6).startWith(0).startWith(7).subscribe { (e) in
            print(e)
            }.disposed(by: disposeBag)
    }


    
//MARK --变换操作
    
//    take仅发送 Observable 的前 n 个数据项
//    1
//    2
//    3
    func takeTest() {
        Observable.of(1, 2, 3, 4, 5)
            .take(3)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
////    distinctUntilChanged过滤掉连续重复的数据
//    1
//    2
//    4
//    5
//    7
//    8
//    9
    func distinctUntilChangedTest() {
        Observable.of(1,1,2,2,4,5,5,7,8,9)
            .distinctUntilChanged()
            .subscribe(onNext: { (e) in
                print(e)
            })
            .disposed(by: disposeBag)
    }
    
//    filter只发送 Observable 中通过特定测试的数据
//    0
//    2
//    4
//    6
//    8
    func filterTest() {
        
            Observable.of(0,1,2,3,4,5,6,7,8,9)
                .filter { $0 % 2 == 0 }
                .subscribe(onNext: { (e) in
                    print(e)
                })
                .disposed(by: disposeBag)
    }
    
//    scan就是给一个初始化的数，然后不断的拿前一个结果和最新的值进行处理操作。
//    11
//    111
//    1111
    func scanTest() {
        
        Observable.of(10, 100, 1000)
            .scan(1) { (aVaule, newValue) -> Int  in
                return aVaule + newValue
            }.subscribe(onNext: { (e) in
                print(e)
            })
            .disposed(by: disposeBag)
        
    }
    
    
    //  flatMap  将一个sequence转换为一个sequences，当你接收一个sequence的事件，你还想接收其他sequence发出的事件的话可以使用flatMap，她会将每一个sequence事件进行处理以后，然后再以一个新的sequence形式发出事件。和Swift中的意思差不多。
//
//    80
//    85
//    90
//    95
//    222
//    550
//    100
    
    //    flatMapLatest flatMapLatest只会接收最新的value事件，将上例改为flatMapLatest。结果为
//
//    80
//    85
//    90
//    550
    func flatMapTest() {

        struct Player {
            var score: Variable<Int>        //里面是一个Variable
        }
        
        let 👦🏻 = Player(score: Variable(80))
        let 👧🏼 = Player(score: Variable(90))
        let 😂 = Player(score: Variable(550))
        
        let player = Variable(👦🏻)  //将player转为Variable
        
        player.asObservable()
            .flatMap { $0.score.asObservable() }//转换成了一个新的序列
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        👦🏻.score.value = 85
        
        player.value = 👧🏼 //更换了value，相当于又添加了一个sequence，两个sequence都可以接收
        
        👦🏻.score.value = 95
        👦🏻.score.value = 222
        player.value = 😂
        
        👧🏼.score.value = 100
    
    }
    
    //map / select 对序列的每一项都应用一个函数来变换 Observable 发射的数据序列
//    next(2)
//    next(4)
//    next(6)
//    completed
    func mapTest() {
        Observable<Int>.of(1, 2, 3)
            .map { $0 * 2 }
            .subscribe { (e) in
                print(e)
            }.disposed(by: disposeBag)
        
    }
    
   

//MARK -- Subjects
    /*
    Subject 可以看成是一个桥梁或者代理，在某些ReactiveX实现中，它同时充当了 Observer 和 Observable 的角色。因为它是一个Observer，它可以订阅一个或多个 Observable；又因为它是一个 Observable，它可以转发它收到(Observe)的数据，也可以发射新的数据。
     
     PublishSubject, ReplaySubject和BehaviorSubject是不会自动发出completed事件的。
     Variable会自动发出Completed 事件
     
*/
    
//    Variable 封装了 BehaviorSubject。使用 variable 的好处是 variable 将不会显式的发送 Error 。在 deallocated 的时候，Variable 会自动的发送 complete 事件。
//    next(z)
//    next(a)
//    next(b)
//    next(b)
//    next(c)
//    next(c)
//    next(d)
//    next(d)
//    completed
//    completed
    func VariableTest() {
        let variable = Variable<Any>("z")
        //asObservable 使用它拆解成Observable， value就是BehaviorSubject
        variable.asObservable()
            .subscribe { (e) in
                print(e)
            }
            .disposed(by: disposeBag)
        
        variable.value = "a"
        variable.value = "b"
        
        variable.asObservable()
            .subscribe { (e) in
                print(e)
            }
            .disposed(by: disposeBag)

        variable.value = "c"
        variable.value = "d"
    }
    
    /// 当观察者订阅 BehaviorSubject 时，它开始发射原始 Observable 最近发射的数据（如果此时还没有收到任何数据，它会发射一个默认值），然后继续发射其它任何来自原始Observable的数据。
//    next(z)
//    next(a)
//    next(b)
//    next(b)
//    next(c)
//    next(c)
//    next(d)
//    next(d)
    func BehaviorSubjectTest() {
        let subject = BehaviorSubject<Any>(value: "z")
        
        subject.subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
        
        subject.onNext("a")
        subject.onNext("b")

        subject.subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
        
        subject.onNext("c")
        subject.onNext("d")

    }
    
//    ReplaySubject 会发射所有来自原始Observable的数据给观察者，无论它们是何时订阅的。当一个新的 observer 订阅了一个 ReplaySubject 之后，他将会收到当前缓存在 buffer 中的数据和这之后产生的新数据
//    next(1)
//    next(1)
//    next(2)
//    next(2)
    func ReplaySubjectTest() {
        let subject = ReplaySubject<Any>.create(bufferSize: 1)
        subject.subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
        
        subject.onNext(1)
        
        subject.subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
        subject.onNext(2)

    }
    
    /// publishSubject 只会把在订阅发生的时间点之后来自原始Observable的数据发射给观察者。
//    next(1)
//    next(2)
//    next(2)

    func PublishSubjectTest() {
        
        let subject = PublishSubject<Any>()
        subject.subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
        
        subject.onNext(1)
        
        subject.subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
        
        subject.onNext(2)

    }
    
    
    
//MARK  --- 创建 一系列 Observable
    
    /// 直到 observer 订阅之后才创建 Observable，并且为每一个 observer 创建一个全新的 Observable
//    creating + 1
//    emmiting
//    next(1)
//    next(2)
//    next(3)
//    creating + 2
//    emmiting
//    next(1)
//    next(2)
//    next(3)
    func deferredTest() {
        var count = 1
        let deferredSequence: Observable<Any> = Observable.deferred { () -> Observable<Any> in
            print("creating + \(count)")
            count = count + 1
            return Observable.create({ (observer) -> Disposable in
                print("emmiting")
                observer.onNext(1)
                observer.onNext(2)
                observer.onNext(3)
                return Disposables.create()
            })
        }
        
        deferredSequence.subscribe { (event) in
            print(event)
        }
        .disposed(by: disposeBag)
        
        deferredSequence.subscribe { (event) in
            print(event)
        }
        .disposed(by: disposeBag)
    }
    
    /// 创建一个不发送任何 item 的 Observable，
    //Error(Error Domain=Test Code=-1 "(null)")
    func errorTest() {
        let error = NSError(domain: "test", code: -1, userInfo: nil)
        
        Observable<Any>.error(error)
            .subscribe { (event) in
                print(event)
        }
        .disposed(by: disposeBag)
    }
    
    /// generate 创建的序列可以自己生成它的值，并且在之前值的基础上来判断什么时候结束。
//    next(0)
//    next(1)
//    next(2)
//    completed
    func generateTest() {
        let observable = Observable.generate(initialState: 0,
                                             condition: { $0 < 3 },
                                             iterate: { $0 + 1})
        observable.subscribe { (e) in
            print(e)
        }
        .disposed(by: disposeBag)
    }
    
    ///自定义Observable
    /// create 使用 Swift 闭包来创建一个序列。创建了 just 操作符的自定义版本。
    //输出
//    next(1)
//    completed
    func createTest() {
        //创建闭包
        let myJust = { (element: Int) -> Observable<Int> in
            return Observable.create({ (observer) -> Disposable in
                observer.on(.next(element))
                observer.on(.completed)
                return Disposables.create()
            })
        }
        
        myJust(1).subscribe { (i) in
            print(i)
        }.disposed(by: disposeBag)
    }
    
    /// just 代表只包含一个元素的序列。它将向订阅者发送两个消息，第一个消息是其中元素的值，另一个是 completed。
    func justTest() {
        let observable = Observable<Any>.just(32)
        observable.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
    }
    
    /// empty 创建一个空的序列。它仅发送 completed 消息。
    func emptyTest() {
        let observable = Observable<Any>.empty()
        observable.subscribe { (event) in
            print(event)  //event 为completed
        }.disposed(by: disposeBag)
    }
    
    /// never 创建一个序列，该序列永远不会发送消息，.Completed 消息也不会发送。
    func neverTest() {
        let observable = Observable<Any>.never()
        observable.subscribe(onNext: { (element) in
            print(element)
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            print("comleted")
        }, onDisposed: {
            print("onDisposed")
            
        })
            .disposed(by: disposeBag)
    }
    
    
    
    /// Of 通过固定数目的元素创建一个序列
    /// 运行结果为
//    next(1)
//    next(2)
//    next(3)
//    completed
    func ofTest() {
        let observable = Observable<Any>.of(1,2,3)
        observable.subscribe { (i) in
            print(i)
        }.disposed(by: disposeBag)
        
        /*
            结果为1
                2
                3
        */
//        observable.subscribe(onNext: { (i) in
//            print(i)
//        },
//        onError: nil,
//        onCompleted: nil,
//        onDisposed: nil)
//        .disposed(by: disposeBag)
        
    }
    
    /// 测试combineLatest
    func combineLatest1Test() {
        Observable.combineLatest(text1.rx.text.orEmpty, text2.rx.text.orEmpty) { (a, b) -> Int in
            print(a,b)
            return (Int(a) ?? 0) + (Int(b) ?? 0)
            }
            .map { $0.description }
            .bind(to: lab.rx.text)
            .disposed(by: disposeBag)
    }

}

