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

    lazy var operaiontQueue: OperationQueue = {
        let op = OperationQueue()
        op.maxConcurrentOperationCount = 1
        return op
    }()
    
    var peoples:[String] = ["xxxxxx1","xxxxxx2","xxxxxx3","xxxxxx4","xxxxxx5","xxxxxx6","xxxxxx7","xxxxxx8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.swiftGCDQueueDemo()
    }

    func createBarrage(text: String) -> UILabel {
        let a = UILabel(frame: CGRect(x: 0, y: 150, width: 100, height: 30))
        a.textColor = UIColor.black
        a.backgroundColor = UIColor.white
        a.text = text
        return a
    }
    
    //线程获取
    func swiftGCDQueueDemo() {
        
        for item in self.peoples {
            let animationOp = AnimationOperation(animationView: self.createBarrage(text: item), parentView: self.view)
            self.operaiontQueue.addOperation(animationOp)
        }
//        self.operaiontQueue.addOperations(ops, waitUntilFinished: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.operaiontQueue.cancelAllOperations()
    }
}

