//
//  BridgePattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/27.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation
/**
 * 桥接模式
 * !@brief 将抽象部分与它的实现部分分离，使它们都可以独立地变化
 */

//Implementor类
private class Implementor {
    
    public func Operation() {
        
    }
}

private class ConcreteImplementorA: Implementor {
    override func Operation() {
        //A的实现
    }
}

private class ConcreteImplementorB: Implementor {
    
    override func Operation() {
        //B的实现
    }
}

//抽象类
private class Abstraction {
    
    private var implementor: Implementor?
    
    public func setImplementor(implementor: Implementor) {
        
    }
}
