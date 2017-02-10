//
//  ViewController.swift
//  GCDDemo
//
//  Created by 逢阳曹 on 2017/2/8.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import UIKit

import Dispatch

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //全局队列 并行队列
        let globalQueue = DispatchQueue.global()
        
        
        //主线程队列 全局唯一 串行队列
        let mainQueue = DispatchQueue.main;
        
        let globalQosQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
        //已废弃
//        DispatchQueue.global(priority: <#T##DispatchQueue.GlobalQueuePriority#>)
        //自定义队列
//        let customQueue = DispatchQueue(label: "com.fengyangcao.serialqueue", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes = default, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = default)
        
        let customQueue = DispatchQueue(label: "com.fengyangcao.serialqueue", qos: DispatchQoS.userInitiated, attributes: DispatchQueue.Attributes.concurrent)
        
//        customQueue.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

