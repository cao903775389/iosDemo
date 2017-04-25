//
//  TemplatePattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/23.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation
/**
 * 模板方法模式
 * !@brief 定义一个操作中的算法的骨架，而将一些步骤延迟到子类中，模板方法使得子类可以不改变一个算法的结构即可重定义该算法的某些特定步骤
 */

//定义一个抽象类
private class AbstractClass {
    
    //模板方法 给出了逻辑的骨架 而逻辑的组成是一些相应的抽象操作，它们都推迟到子类实现
    final public func TemplateMethod() {
        //此方法不允许子类继承
    }
    
    //一些抽象行为 放到子类去实现
    public func PrimitiveOperation1() {
        //for subclass to overload
    }
    
    public func PrimitiveOperation2() {
        //for subclass to overload
    }
}

//定义具体的实现类
private class ConcreteClassA: AbstractClass {
    
    override func PrimitiveOperation1() {
        //具体方法A的实现
    }
    
    override func PrimitiveOperation2() {
        //具体方法A的实现
    }
    
}

private class ConcreteClassB: AbstractClass {
    
    override func PrimitiveOperation1() {
        //具体方法B的实现
    }
    
    override func PrimitiveOperation2() {
        //具体方法B的实现
    }
    
}


private class Client {
    func main() {
        var c: AbstractClass?
        c = ConcreteClassA()
        c?.TemplateMethod()
        
        c = ConcreteClassB()
        c?.TemplateMethod()
        
    }
}

