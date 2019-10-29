//
//  AppDelegate.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/3/28.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import AVFoundation

import GuidePageView
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    fileprivate let avSpeech = AVSpeechSynthesizer()
    var window: UIWindow?
    var  mapManager: BMKMapManager?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        configJupsh(launchOptions: launchOptions)

        
        XLocationManager.shareUserInfonManager.startUpLocation()

        BMKLocationAuth.sharedInstance()?.checkPermision(withKey: AK, authDelegate: self)
        //要使用百度地图，请先启动BMKMapManager
        mapManager = BMKMapManager()
        /**
         百度地图SDK所有API均支持百度坐标（BD09）和国测局坐标（GCJ02），用此方法设置您使用的坐标类型.
         默认是BD09（BMK_COORDTYPE_BD09LL）坐标.
         如果需要使用GCJ02坐标，需要设置CoordinateType为：BMK_COORDTYPE_COMMON.
         */
        if BMKMapManager.setCoordinateTypeUsedInBaiduMapSDK(BMK_COORD_TYPE.COORDTYPE_BD09LL) {
            NSLog("经纬度类型设置成功")
        } else {
            NSLog("经纬度类型设置失败")
        }
        //启动引擎并设置AK并设置delegate
        if !(mapManager!.start(AK, generalDelegate: self)) {
            NSLog("启动引擎失败")
        }

        PPGetAddressBook.requestAddressBookAuthorization()
        
        let useDefaults = UserDefaults.standard
        let v = useDefaults.object(forKey: "first")
        
        if v != nil  {
            window?.rootViewController = SNMainTabBarController.shared
        }else{
            window?.rootViewController = ViewController()
            useDefaults.set(false, forKey: "first")
        }
        let NotifyOne = NSNotification.Name(rawValue:"TAG")
        NotificationCenter.default.addObserver(self, selector: #selector(setTag(notify:)), name: NotifyOne, object: nil)
        
        let NotifyTwo = NSNotification.Name(rawValue:"DELETE")
        NotificationCenter.default.addObserver(self, selector: #selector(deleteTag(notify:)), name: NotifyTwo, object: nil)
        

        self.window?.makeKeyAndVisible()
        return true
    }
    @objc func setTag(notify:NSNotification){
        guard let text: String = notify.object as! String? else { return }
        CNLog(text)
//        JPUSHService.setTags([text], completion: nil, seq: 0)
        JPUSHService.setTags([text], completion: { (iResCode, iAlias, seq) in
            print("alias,\(iAlias) . completion,\(iResCode),\(iAlias),\(seq)")
        }, seq: 0)
//        JPUSHService.setAlias(text, completion: { ( code,string,seq) in
//            CNLog(code + "+" + string +  "+" +  seq)
//        }, seq: 0)
        JPUSHService.setAlias(text, completion: { (iResCode, iAlias, seq) in
            print("alias,\(iAlias) . completion,\(iResCode),\(iAlias),\(seq)")
        }, seq: 0)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func deleteTag(notify:NSNotification){
        guard let text: String = notify.object as! String? else { return }
        CNLog(text)
        JPUSHService.deleteTags([text], completion: { (iResCode, iAlias, seq) in
            print("退出注销极光别名儿 \(iResCode),\(String(describing: iAlias)),\(seq)")
        }, seq: 0)
        
        JPUSHService.deleteAlias({ (iResCode, iAlias, seq) in
            print("退出注销极光别名儿 \(iResCode),\(String(describing: iAlias)),\(seq)")
        }, seq: 0)
        //        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func startTranslattion(_ string:String){
        //1. 创建需要合成的声音类型
        let voice = AVSpeechSynthesisVoice(language: "zh-CN")
        
        //2. 创建合成的语音类
        let utterance = AVSpeechUtterance(string:string)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.voice = voice
        utterance.volume = 1
        utterance.postUtteranceDelay = 0.1
        utterance.pitchMultiplier = 1
        //开始播放
        avSpeech.speak(utterance)
    }

    
    
    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    //*-------------------------------RemoteNotifications--------------------------------*/
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        JPUSHService.handleRemoteNotification(userInfo)
        let aps = userInfo["aps"] as! NSDictionary
        let alert = aps["alert"] as! String
        startTranslattion(alert)
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        JPUSHService.registerDeviceToken(deviceToken)
        let registrationID = JPUSHService.registrationID()
        UserDefaults.standard.set(registrationID, forKey: "registrationID")
        UserDefaults.standard.set(registrationID, forKey: "deviceToken")
//        JPUSHService.setAlias(registrationID, completion: nil, seq: 0)
        JPUSHService.setAlias(registrationID, callbackSelector: nil, object: nil)
        CNLog("JPUSHService.registrationID=\(JPUSHService.registrationID() ?? "0")")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        JPUSHService.handleRemoteNotification(userInfo)
        let aps = userInfo["aps"] as! NSDictionary
        let alert = aps["alert"] as! String
        startTranslattion(alert)
        completionHandler(.newData)
    }

}

extension AppDelegate:BMKGeneralDelegate,BMKLocationAuthDelegate{
   
    /**
     联网结果回调
     
     @param iError 联网结果错误码信息，0代表联网成功
     */
    func onGetNetworkState(_ iError: Int32) {
        if 0 == iError {
            NSLog("联网成功")
        } else {
            NSLog("联网失败：%d", iError)
        }
    }
    
    /**
     鉴权结果回调
     
     @param iError 鉴权结果错误码信息，0代表鉴权成功
     */
    func onGetPermissionState(_ iError: Int32) {
        if 0 == iError {
            NSLog("授权成功")
        } else {
            NSLog("授权失败：%d", iError)
        }
    }
    
}
extension AppDelegate:JPUSHRegisterDelegate{
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
        
    }
    
    
    func configJupsh(launchOptions:[UIApplication.LaunchOptionsKey: Any]?) ->Void {
        CNLog((launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? NSDictionary))
        
        
        if #available(iOS 10.0, *){
            let entiity = JPUSHRegisterEntity()
            entiity.types = Int(UNAuthorizationOptions.alert.rawValue |
                UNAuthorizationOptions.badge.rawValue |
                UNAuthorizationOptions.sound.rawValue)
            JPUSHService.register(forRemoteNotificationConfig: entiity, delegate: self)
        } else if #available(iOS 8.0, *) {
            
            let types = UIUserNotificationType.badge.rawValue |
                UIUserNotificationType.sound.rawValue |
                UIUserNotificationType.alert.rawValue
            JPUSHService.register(forRemoteNotificationTypes: types, categories: nil)
        }else {
            let type = UIRemoteNotificationType.badge.rawValue |
                UIRemoteNotificationType.sound.rawValue |
                UIRemoteNotificationType.alert.rawValue
            JPUSHService.register(forRemoteNotificationTypes: type, categories: nil)
        }
        
        JPUSHService.setup(withOption: launchOptions,
                           appKey: JPushAppKey,
                           channel: "app store",
                           apsForProduction: true)
    }
    
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            JPUSHService.handleRemoteNotification(userInfo)
            CNLog(notification.request.content.body)
            CNLog(notification.request.content.title)
            CNLog(notification.request.content.subtitle)
            CNLog(notification.request.content.userInfo)
            let aps = userInfo["aps"] as! NSDictionary
            let alert = aps["alert"] as! String
            let amount = userInfo["amount"] as! String
            
//            let sound = aps["sound"] as! String
//            print(sound)
            startTranslattion("筋斗云收款到账" + amount + "元")
            
            
        } else {// 本地通知
            
        }
        
        completionHandler(Int(UNAuthorizationOptions.alert.rawValue |
            UNAuthorizationOptions.badge.rawValue |
            UNAuthorizationOptions.sound.rawValue))
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        let userInfo = response.notification.request.content.userInfo
        
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            JPUSHService.handleRemoteNotification(userInfo)
            let aps = userInfo["aps"] as! NSDictionary
            let alert = aps["alert"] as! String
            let amount = userInfo["amount"] as! String
            CNLog(amount)
            startTranslattion("筋斗云收款到账" + amount + "元")

        } else {// 本地通知
        }
        completionHandler()
    }
    
    
}
