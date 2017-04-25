//
//  StatePattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/27.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation
/**
 * 状态模式
 * !@brief 当一个对象的内在状态改变时允许改变其行为，这个对象看起来像是改变了其类
 *  状态模式主要解决的是当控制一个对象状态转换的条件表达式过于复杂时的情况，把状态判断逻辑转移到表示不同状态的一系列类当中，可以把复杂的判断逻辑简化
 */

//定义一个抽象状态类或者接口以封装与Context的一个特定状态相关的行为
private class State {
    
    public func handle(context: Context) {
        
    }
}

private class ConcreteStateA: State {
    
    override func handle(context: Context) {
        //设置ConcreteStateA的下一状态是ConcreteStateB
        context.state = ConcreteStateB()
    }
}

private class ConcreteStateB: State {
    override func handle(context: Context) {
        //设置ConcreteStateB的下一状态是ConcreteStateA
        context.state = ConcreteStateA()
    }
}

//Context类 维护一个ConcreteState子类的实例，这个实例定义当前的状态
private class Context {
    
    var state: State?
    convenience init(state: State) {
        self.init()
        self.state = state
    }
    
    public func request() {
        //对请求做处理，并设置下一状态
        self.state?.handle(context: self)
    }
}

private class Client {
    
    func mainc() {
        
        let c = Context(state: ConcreteStateA())
        //不断的请求，同时更改状态
        c.request()
        c.request()
        c.request()
        c.request()
    }
}
