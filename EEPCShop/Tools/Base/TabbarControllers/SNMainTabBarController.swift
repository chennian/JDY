//
//  SNMainTabBarController.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/12.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import RxSwift

class SNMainTabBarController: UITabBarController {
    
    static let shared = SNMainTabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setup()
    }

    
    override var selectedIndex: Int{
        willSet{
            ZJLog(messagr: selectedIndex)
        }
    }
}

fileprivate extension SNMainTabBarController {
    //community__current  community_default  新加社区图片
    
    func setup() {
        self.tabBar.alpha = 1
        let home = navi(HomePageController(), title: "首页", image: "home_default", selectedImage: "home_current")
        let find = navi(TogetherController(), title: "电话", image: "phone_default", selectedImage: "phone_current")
        
        let community = navi(CommunityController(), title: "社区", image: "community_default", selectedImage: "community__current")

        let pay = navi(PayLogViewController(), title: "我的账单", image: "bill_default", selectedImage: "bill__current")
        let mine = navi(MineCenterController(), title: "我的", image: "mine_default", selectedImage: "mine_current")

//
        self.viewControllers = [home,find,community,pay,mine]
        
        self.delegate = self
    }
    
    func customTabbarItem(title: String?, image: String?, selectedImage: String?) -> UITabBarItem {
        
        let bar = UITabBarItem()
        
        if let t = title {
            bar.title = t
        }
        
        if let img = image {
            bar.image = Image(img)
        }
        
        if let simg = selectedImage {
            bar.selectedImage = Image(simg)
        }
        
        return bar
    }

}

extension SNMainTabBarController{
    func navi(_ vClass: UIViewController, title: String, image: String, selectedImage: String) -> UIViewController {
        
        vClass.tabBarItem = customTabbarItem(title: nil, image: image, selectedImage: selectedImage)
        //        vClass.tabBarItem.title = title
        vClass.title = title
        
        let selAttr = [
            NSAttributedString.Key.foregroundColor : Color(0x3660fb)
        ]
        
        let defAttr = [
            NSAttributedString.Key.foregroundColor : Color(0xc6c9d6)
        ]
        
        vClass.tabBarItem.setTitleTextAttributes(defAttr, for: .normal)
        vClass.tabBarItem.setTitleTextAttributes(selAttr, for: .selected)
        
        
        let navi = SNBaseNaviController(rootViewController: vClass)
        navi.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : Font(36)]
        return navi
    }
}
extension SNMainTabBarController : UITabBarControllerDelegate {
    

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
}
