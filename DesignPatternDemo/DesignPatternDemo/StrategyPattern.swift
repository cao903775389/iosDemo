//
//  StrategyPattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/21.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation
/**
 * 策略模式
 * !@brief 定义了算法家族，分别封装起来，让它们之间可以互相替换，此模式让算法的变化，不会影响到使用算法的客户
 */


//Context上下文 用一个具体的ConcreteStrategy来配置 维护一个对strategy对象的引用
private class Context {
    
    public var strategy: Strategy?
    
    public required convenience init(strategy: Strategy) {
        self.init()
        self.strategy = strategy
    }
    
    //上下文接口
    public func ContextInterface() {
        self.strategy?.AlgorithmInterface()
    }
    
}

//抽象算法类
private class Strategy {
    
    public func AlgorithmInterface() {
        
    }
}

//具体算法类A
private class ConcreteStrategyA: Strategy {
    
    //算法A的实现方法
    override public func AlgorithmInterface() {
        
    }
}

//具体算法类B
private class ConcreteStrategyB: Strategy {
    //算法B的实现方法
    override func AlgorithmInterface() {
        
    }
}

//使用场景
private class Client {
    
    func main() {
        
        var context = Context(strategy: ConcreteStrategyA())
        context.ContextInterface()
        
        context = Context(strategy: ConcreteStrategyB())
        context.ContextInterface()
        
    }
}







