//
//  AppDelegate.swift
//  VM
//
//  Created by MunchEm on 18/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        if #available(iOS 11, *) {
         let statusBar = UIView()
    statusBar.backgroundColor = UIColorFromRGB(rgbValue:0x007AFF)
    UIApplication.shared.keyWindow?.addSubview(statusBar)
    if UIDevice.current.userInterfaceIdiom == .phone
        {
       let  screen = UIScreen.main.bounds.size.height
       if screen>=812{
       statusBar.frame.size.height=30
                   }
           }
        }
     else
      {
    let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
    statusBar.backgroundColor = UIColorFromHex(rgbValue: 0x007AFF)
        }
            
    if UIDevice.current.userInterfaceIdiom == .phone
           {
               let  screen = UIScreen.main.bounds.size.height
               if screen>=812{
                   
                   statusBar.frame.size.height=30
               }
           }
        }

        
        return true
    }
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
           let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
           let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
           let blue = CGFloat(rgbValue & 0xFF)/256.0
           
           return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
       }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

