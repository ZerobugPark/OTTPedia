//
//  Observable.swift
//  OTTPedia
//
//  Created by youngkyun park on 2/5/25.
//

import Foundation


class Observable<T> {
    
    
    var closure: ((T) -> ())?
    
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    //bind: 묶다 아마 객체가 어떤 이벤트가 발생했을 때, 업데이트를 하기위해 묶어서 관리?때문에 bind라는 용어를 쓰는 걸까?
    func bind(_ closure: @escaping (T) -> (Void)) {
        closure(value)
        self.closure = closure
        
    }
    
    func lazyBind(_ closure: @escaping (T) -> (Void)) {
        self.closure = closure
        
    }
    
    
}
