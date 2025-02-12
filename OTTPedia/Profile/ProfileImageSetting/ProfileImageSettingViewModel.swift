//
//  ProfileImageSettingViewModel.swift
//  OTTPedia
//
//  Created by youngkyun park on 2/10/25.
//

import Foundation


final class ProfileImageSettingViewModel: BaseViewModel {
    
    
    private(set) var input: Input
    private(set) var output: Output
    
    
    struct Input {
        let viewDidLoad: Observable<Void> = Observable(())
        let didSelected: Observable<Int> = Observable((0))
    }
    
    struct Output {
        let currentImageIndex: Observable<Int> = Observable(0)
        let imageStatus: Observable<Void> = Observable(())
        let updateImage: Observable<(Int,Int)> = Observable((0,0))
        var profileStatus: [(Int, Bool)] = []
        let navigationTitle = "프로필 이미지 설정"
    }
    
    
    var changedImage: ((Int) -> Void)?
    
    
    
    private var previousImageIndex = 0
    
    init() {
        print("ProfileImageSettingViewModel Init")
        input = Input()
        output = Output()
        transform()
        
    }
    
    func transform() {
        input.viewDidLoad.lazyBind { [weak self] _ in
            self?.imageViewInit(value: self!.output.currentImageIndex.value)
        }
        
        input.didSelected.lazyBind { [weak self] idx  in
            self?.imageSelected(index: idx)
        }
    }
    
    private func imageViewInit(value: Int) {
        for i in 0..<ImageList.shared.profileImageList.count {
            
            if output.currentImageIndex.value == i {
                output.profileStatus.append((i,true))
            } else {
                output.profileStatus.append((i,false))
            }
        }
        output.imageStatus.value = ()
    }
    
    private func imageSelected(index: Int) {
        
        if output.currentImageIndex.value != index {
            previousImageIndex = output.currentImageIndex.value
            output.currentImageIndex.value = index
            print(previousImageIndex, output.currentImageIndex.value)

            output.profileStatus[previousImageIndex] = (previousImageIndex, false)
            output.profileStatus[output.currentImageIndex.value] = (output.currentImageIndex.value, true)
            
            output.updateImage.value = (previousImageIndex, output.currentImageIndex.value)
        
            changedImage?(index)

        }
        
        
        
    }
    
    deinit {
        print("ProfileImageSettingViewModel deinit")
    }
}
