//
//  ViewController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/3/28.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class ViewController:UIViewController,UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUp()
        setUI()
    }
    
    private func setUp(){
    }
    private func setUI(){
        view.addSubview(scrollV)
        scrollV.delegate = self
        view.addSubview(pageCotrol)
        pageCotrol.numberOfPages = 3
        pageCotrol.currentPageIndicatorTintColor = Color(0xf5f5f5)
        pageCotrol.pageIndicatorTintColor = Color(0xa9aebe)
        pageCotrol.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(fit(-120))
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        
        
        for i in 1 ..< 4{
            let imgStr = "one" + "\(i)"
            let imgV = UIImageView(image: UIImage(named: imgStr))
            scrollV.addSubview(imgV)
            imgV.frame = CGRect(x: ScreenW * CGFloat(i - 1), y: 0, width: ScreenW, height: ScreenH)
            imgV.isUserInteractionEnabled = true
            
            
            if i == 3{
                let button = UIButton()
                button.layer.cornerRadius = fit(40)
                button.clipsToBounds = true
                button.setTitle("立即体验", for: .normal)
                button.setTitleColor(Color(0xf5f5f5), for: .normal)
                button.layer.borderWidth = fit(1)
                button.layer.borderColor = Color(0x3660fb).cgColor
                imgV.addSubview(button)
                button.snp.makeConstraints({ (make) in
                    make.centerX.equalToSuperview()
                    make.width.snEqualTo(290)
                    make.height.snEqualTo(80)
                    make.bottom.equalToSuperview().offset(-90)
                })
                button.addTarget(self, action: #selector(beginClcik), for: .touchUpInside)
            }
        }
        scrollV.contentSize = CGSize(width: ScreenW * 3.0, height: 0)
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.isPagingEnabled = true
        scrollV.bounces = false
    }
    @objc private func beginClcik(){
        UIApplication.shared.keyWindow?.rootViewController = SNMainTabBarController.shared
    }
    private lazy var scrollV : UIScrollView = {
        let obj = UIScrollView(frame: self.view.bounds)
        return obj
    }()
    
    private lazy var pageCotrol : UIPageControl = {
        let obj = UIPageControl()
        return obj
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollV.contentOffset.x + ScreenW * 0.5) / Int(ScreenW)
        pageCotrol.currentPage = currentIndex
        pageCotrol.isHidden = currentIndex == 2
        
    }
}
