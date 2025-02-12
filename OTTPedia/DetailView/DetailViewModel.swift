//
//  DetailViewModel.swift
//  OTTPedia
//
//  Created by youngkyun park on 2/12/25.
//

import Foundation


class DetailViewModel: BaseViewModel {
    
    
    private(set) var input: Input
    private(set) var output: Output
    
    
    struct Input {
        
    }
    
    struct Output {
        
    }

    init() {
        print("DetailViewModel Init")
        input = Input()
        output = Output()
    }
    
    
    func transform() {
        
    }
    
    
    deinit {
        print("DetailViewModel DeInit")
    }
    
    
    
    
    
}
