//
//  DetailViewController.swift
//  OTTPedia
//
//  Created by youngkyun park on 1/28/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    private var detailView = DetailView()

    
    let color:[UIColor] = [.red,.blue,.green,.yellow,.purple]
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.scrollView.delegate = self
        
        
        
        
        
    }
    
    private func addContentScrollView() {
        for i in 0..<5 {
            let imageView = UIImageView()
            let xPos = detailView.scrollView.frame.width * CGFloat(i)
            // print(xPos)
            imageView.frame = CGRect(x: xPos, y: 0, width: detailView.scrollView.bounds.width, height: detailView.scrollView.bounds.height)
            imageView.backgroundColor = color[i]
            detailView.scrollView.addSubview(imageView)
            detailView.scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
    }
    
    private func setPageControl() {
        detailView.pageControl.numberOfPages = 5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        addContentScrollView()
        setPageControl()

    }
    
    
    
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //scrollView.contentOffset.x : 스크롤뷰가 움직이는 실시간 좌표 값
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        // print(scrollView.contentOffset.x)
        
        //value 자체를 rounded를 할 경우, isNan 및 isInfinite 오류 발생
        //해결 -> 타입 자체를 Int로 먼저 바꾸지 말고, 실수형으로 바꾼 뒤 Int로 변환해서 해결(정밀하지 않아도 되니 Float로 구현)
        let index = lroundf(Float(value))
        setPageControlSelectedPage(currentPage: Int(index))
        
    }
    private func setPageControlSelectedPage(currentPage:Int) {
        detailView.pageControl.currentPage = currentPage
    }
}

