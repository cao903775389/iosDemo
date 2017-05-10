//
//  AppDelegate.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/15.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import UIKit

protocol TestPro: class {
    
    func test1()
    
    func test2()
}

extension TestPro {
    
    func test1() {
        print("1执行了")
    }
    
    func test2() {
        print("2执行了")
    }
}

class Request {
    
    weak var delegate: TestPro?
    
    init() {
        
    }
}

class ClassOne: TestPro {
    func test1() {
        print("class one test1 执行")
    }
}

class ClassTwo: ClassOne {
    
//     override func test1() {
//        print("class two test1 执行")
//    }
//    
//     func test2() {
//        print("class two test2 执行")
//    }
}

class ClassThree: ClassTwo {
    
    override func test1() {
        print("class three test1 执行")
    }
    
    func test2() {
        print("class three test2 执行")
    }
}


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let classTwo = ClassThree()
        
        let r = Request()
        r.delegate = classTwo
        
        r.delegate?.test1()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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


}

