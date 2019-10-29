//
//  TogetherController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/12.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class TogetherController: SNBaseViewController {
    
    var firstVc = WebPhoneViewController()
    
    var secondVc = AddressBookViewController().then{
        $0.token = XKeyChain.get(TOKEN)

    }
//    var secondVc = ContactController()
    
    var currentVC = UIViewController()
    
    var index:NSInteger = 0
    
    override func setupView() {
        
                
        
        self.firstVc.view.frame = CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH - LL_TabbarHeight)
        
        self.secondVc.view.frame = CGRect(x:0, y: 0, width: ScreenW, height: ScreenH - LL_TabbarHeight)
        
        
        self.addChild(firstVc)
        self.addChild(secondVc)
        
        
        self.currentVC = firstVc
        self.view.addSubview(firstVc.view)
        
        self.navigationItem.titleView  =  self.setupSegment()
        
    }
    
    func setupSegment() -> UISegmentedControl {
        let items = ["打电话","联系人"]
        let sgc = UISegmentedControl.init(items: items)
        sgc.setWidth(70, forSegmentAt: 0)
        sgc.setWidth(70, forSegmentAt: 1)
        
        sgc.selectedSegmentIndex = 0
        sgc.addTarget(self, action: #selector(segmentChange(_ :)), for: .valueChanged)
        
        return sgc
    }
    
    func switchVC(_ old:UIViewController ,_ new:UIViewController){
        self.addChild(new)
        self.transition(from: old, to: new, duration: 0, options: .transitionCrossDissolve, animations: nil) { finished in
            if finished {
                new.didMove(toParent:self)
                old.willMove(toParent: nil)
                old.removeFromParent()
                self.currentVC = new;
                
                CNLog(self.currentVC)
            }else{
                self.currentVC = old
                CNLog(self.currentVC)

            }
        }
        
    }
    
    @objc func segmentChange(_ sgc:UISegmentedControl){
        self.index = sgc.selectedSegmentIndex
        
        switch sgc.selectedSegmentIndex {
        case 0:
            
            self.switchVC(self.secondVc, self.firstVc)
            break
        case 1:
            self.switchVC(self.firstVc, self.secondVc)
            break
        default:
            break
        }
    }
}
