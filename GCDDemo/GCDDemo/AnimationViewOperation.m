//
//  AnimationViewOperation.m
//  GCDDemo
//
//  Created by 逢阳曹 on 2017/5/4.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

#import "AnimationViewOperation.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationOperationState) {
    AnimationReady = 0,
    AnimationFinished,
    AnimationExecuting
};
@interface AnimationViewOperation ()
@property (nonatomic, strong) UILabel *animationView;
@property (nonatomic, assign) AnimationOperationState state;
@property (nonatomic, weak) UIView *parentView;
@end

@implementation AnimationViewOperation


- (BOOL)isExecuting {
    return self.state == AnimationExecuting;
}

- (BOOL)isFinished {
    return self.state == AnimationFinished;
}

- (AnimationViewOperation *)init: (UILabel *)animationView  parentView: (UIView *)parentView {
    
    if (self = [super init]) {
        self.animationView = _animationView;
        self.parentView = parentView;
    }
    return self;
}

- (void)start {
    if ([self isCancelled]) {
        [self willChangeValueForKey:@"isFinished"];
        self.state = AnimationFinished;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    self.state = AnimationExecuting;
    [self didChangeValueForKey:@"isExecuting"];
    
    [NSOperationQueue.mainQueue addOperationWithBlock:^{
        [UIView animateKeyframesWithDuration:3.0 delay:0.0 options:(UIViewKeyframeAnimationOptionAllowUserInteraction) animations:^{
            
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
                self.animationView.frame = CGRectMake(100, 150, 100,30);
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.8 animations:^{
                self.animationView.frame = CGRectMake(100, 50,100,30);
                self.animationView.alpha = 0.0;
            }];
        } completion:^(BOOL finished) {
            [self.animationView removeFromSuperview];
            [self willChangeValueForKey: @"isFinished"];
            self.state = AnimationFinished;
            [self didChangeValueForKey: @"isFinished"];
        }];
    }];
}

- (void)cancel {
    if (!self.isExecuting || self.isCancelled) { return; }
    [super cancel];
    [self.animationView removeFromSuperview];
    [self willChangeValueForKey: @"isFinished"];
    self.state = AnimationFinished;
    [self didChangeValueForKey: @"isFinished"];
}

@end



//@property (stron)
//private var animationView: UILabel?
//
//private var state: AnimationOperationState! = .AnimationReady
//
//public var finishBlock: FinishBlock?
//
//public var parentView: UIView?
//
//override var isExecuting: Bool {
//    get {
//        return self.state == .AnimationExecuting
//    }
//}
//
//override var isFinished: Bool {
//    get {
//        return self.state == .AnimationFinished
//    }
//}
//
//
//public init(animationView: UILabel, parentView: UIView) {
//    self.animationView = animationView
//    self.parentView = parentView
//}
//
//override func start() {
//    guard !self.isCancelled else {
//        self.willChangeValue(forKey: "isFinished")
//        self.willChangeValue(forKey: "state")
//        
//        self.state = .AnimationFinished
//        self.didChangeValue(forKey: "isFinished")
//        self.didChangeValue(forKey: "state")
//        return
//    }
//    
//    self.willChangeValue(forKey: "isExecuting")
//    self.state = .AnimationExecuting
//    self.didChangeValue(forKey: "isExecuting")
//    
//    OperationQueue.main.addOperation {
//        self.parentView?.addSubview(self.animationView!)
//        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.allowUserInteraction, animations: {
//            
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
//                self.animationView!.frame = CGRect(x: 100, y: 150, width: 100, height: 30)
//            })
//            
//            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8, animations: {
//                self.animationView!.frame = CGRect(x: 100, y: 50, width: 100, height: 30)
//                self.animationView!.alpha = 0.0
//            })
//            
//        }, completion: { (finished) in
//            self.animationView!.removeFromSuperview()
//            self.willChangeValue(forKey: "isFinished")
//            self.state = .AnimationFinished
//            self.didChangeValue(forKey: "isFinished")
//            self.finishBlock?(finished)
//        })
//    }
//}
//
//override func cancel() {
//    if !self.isExecuting { return }
//    super.cancel()
//    self.willChangeValue(forKey: "isFinished")
//    self.willChangeValue(forKey: "state")
//    
//    self.state = .AnimationFinished
//    self.didChangeValue(forKey: "isFinished")
//    
//    self.didChangeValue(forKey: "state")
//}

