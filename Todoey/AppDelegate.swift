//
//  AppDelegate.swift
//  Todoey
//
//  Created by Administrator on 5/21/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do{
            let realm = try Realm()
        }catch{
            print("Error initialising new realm, \(error)")
        }
        
        return true
    }


    
    
   


}

