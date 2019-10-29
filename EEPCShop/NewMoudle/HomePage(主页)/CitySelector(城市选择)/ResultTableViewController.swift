//
//  ResultTableViewController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/10/22.
//  Copyright © 2019 CHENNIAN. All rights reserved.
//

import UIKit
private let resultCell = "resultCell"

class ResultTableViewController: UITableViewController {

    var resultArray:[String] = []
    var isFrameChange = false
        /// 点击cell回调闭包
    var callBack: (_ para:String) -> () = {_ in }
    
        @objc  func  submitData(_ city:String){
            let NotifMycation = NSNotification.Name(rawValue:"cityName")
            NotificationCenter.default.post(name: NotifMycation, object: city)
            self.navigationController?.popViewController(animated: true)
        }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // 控制器根据所在界面的status bar，navigationbar，与tabbar的高度，不自动调整scrollview的 inset
            self.automaticallyAdjustsScrollViewInsets = false
            
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: resultCell)
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return resultArray.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell =  tableView.dequeueReusableCell(withIdentifier: resultCell, for: indexPath)
            cell.textLabel?.text = resultArray[indexPath.row]
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath)
            print(cell?.textLabel?.text ?? "")
            
//            submitData((cell?.textLabel?.text!)!)
//
//            // 点击cell调用闭包
            callBack((cell?.textLabel!.text)!)
        }
        
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            
            // 设置view的frame
            if isFrameChange == false {
                view.frame = CGRect(x: 0, y: LL_StatusBarAndNavigationBarHeight + 44, width: ScreenWidth, height: ScreenHeight - LL_StatusBarAndNavigationBarHeight - 44)
                isFrameChange = true
            }
            
        }
    }
