//
//  DecoratorPattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/21.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation
/**
 * 装饰模式
 * !@brief 动态地给一个对象添加一些额外的职责，就增加功能来说，装饰模式比生成子类更为灵活
 */

//抽象类 或者抽象接口
private class Component {
    
     func Operation() {
        
    }
}

//装饰抽象类 实现了Component接口 或者继承自Component
private class Decorator: Component {
    
    var component: Component?
    
    func setComponent(component: Component) {
        self.component = component
    }
    
    //对于Component来说 是无需知道Decorator的存在的
    override func Operation() {
        
    }
}

//具体的装饰类 用于给Component添加职责的功能
private class ConcreteDecoratorA: Decorator {
    
    //A类特有的功能
    private var addedState: String?
    
     override func Operation() {
        super.Operation()
        addedState = "New State"
    }
}

private class ConcreteDecoratorB: Decorator {
    
    //B类特有的功能
    private func AddedBehavior() {
        
    }
    
    override func Operation() {
        super.Operation()
        self.AddedBehavior()
    }
}

private class Client {
    
    func main() {
        
        let cop = Component()
        let d1 = ConcreteDecoratorA()
        //A来装饰cop
        d1.setComponent(component: cop)
        //B来装饰cop
        let d2 = ConcreteDecoratorB()
        d2.setComponent(component: cop)
        
        //执行原有操作
        d2.Operation()
    }
}

