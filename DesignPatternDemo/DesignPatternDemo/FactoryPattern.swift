//
//  FactoryPattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/15.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation

/**
 * 简单工厂模式: 工厂类中包含的必要的逻辑判断，根据客户端的选择条件动态实例化相关的类，对于客户端来说，去除了与具体产品的依赖 但是在增加新的功能时 可能会在之前工厂类的基础上添加一个case的分支条件，进而修改了原有的类，对扩展开放但是同时也对修改开放了 违反了开闭原则
 *  工厂方法模式模式:定义一个用于创建对象的接口，让子类决定实例化哪一个类。Factory Method 使一个类的实例化延迟到其子类。
 *
 */

//定义一个用于创建对象的抽象工厂接口
private protocol AbstractFactoryCreator {
    
    //定义一个用于创建产品抽象方法
    func FactoryMethod() -> AbstractProduct
}

//定一个具体的工厂对象A 实现了抽象接口
private class ConcreteFactoryA: AbstractFactoryCreator {
    
    func FactoryMethod() -> AbstractProduct {
        let product = ConcreteProductA()
        product.Method1()
        return product
    }
}

//定一个具体的工厂对象B 实现了抽象接口
private class ConcreteFactoryB: AbstractFactoryCreator {
    
    func FactoryMethod() -> AbstractProduct {
        let product = ConcreteProductB()
        product.Method1()
        return product
    }
}

//定义一个抽象的产品
private class AbstractProduct {
    
    public func Method1() {
        //业务逻辑
    }
}

//定义一个具体的产品A
private class ConcreteProductA: AbstractProduct {
    override func Method1() {
        //具体的业务逻辑A
    }
}

//定义一个具体的产品B
private class ConcreteProductB: AbstractProduct {
    override func Method1() {
        //具体的业务逻辑B
    }
}


//模拟业务场景
private class Client {
    
    func main() {
        
        let creatorA = ConcreteFactoryA()
        let productA = creatorA.FactoryMethod()
        
        let creatorB = ConcreteFactoryB()
        let productB = creatorB.FactoryMethod()
        
        print(productA,productB)
        //继续处理业务逻辑
    }
}




