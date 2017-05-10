//
//  AnimationOperation.swift
//  GCDDemo
//
//  Created by 逢阳曹 on 2017/5/3.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation

enum AnimationOperationState {
    case AnimationReady
    case AnimationFinished
    case AnimationExecuting
}

typealias FinishBlock = (Bool) -> Void

class AnimationOperation: Operation {
    
    private var animationView: UILabel?
    
    private var state: AnimationOperationState! = .AnimationReady
    
    public var finishBlock: FinishBlock?
    
    public var parentView: UIView?
    
    override var isExecuting: Bool {
        get {
            return self.state == .AnimationExecuting
        }
    }
    
    override var isFinished: Bool {
        get {
            return self.state == .AnimationFinished
        }
    }
    
    
    public init(animationView: UILabel, parentView: UIView) {
        self.animationView = animationView
        self.parentView = parentView
    }
    
    override func start() {
        guard !self.isCancelled else {
            self.willChangeValue(forKey: "isFinished")
            self.willChangeValue(forKey: "state")

            self.state = .AnimationFinished
            self.didChangeValue(forKey: "isFinished")
            self.didChangeValue(forKey: "state")
            return
        }
        
        self.willChangeValue(forKey: "isExecuting")
        self.state = .AnimationExecuting
        self.didChangeValue(forKey: "isExecuting")
        
        OperationQueue.main.addOperation {
            self.parentView?.addSubview(self.animationView!)
            UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.allowUserInteraction, animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: { 
                    self.animationView!.frame = CGRect(x: 100, y: 150, width: 100, height: 30)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8, animations: { 
                    self.animationView!.frame = CGRect(x: 100, y: 50, width: 100, height: 30)
                    self.animationView!.alpha = 0.0
                })
                
            }, completion: { (finished) in
                self.animationView!.removeFromSuperview()
                self.willChangeValue(forKey: "isFinished")
                self.state = .AnimationFinished
                self.didChangeValue(forKey: "isFinished")
                self.finishBlock?(finished)
            })
        }
    }
    
    override func cancel() {
        if !self.isExecuting { return }
        super.cancel()
        self.willChangeValue(forKey: "isFinished")
        self.state = .AnimationFinished
        self.didChangeValue(forKey: "isFinished")
        
    }
}
