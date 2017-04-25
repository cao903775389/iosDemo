//
//  BuilderPattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/23.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation
/**
 * 建造者模式(生成器模式)
 * !@brief 将一个复杂对象的构建与它的表示分离，使得同样的构建过程可以创建不同的表示
 */

//定义一个产品类
private class Product {
    
    //组装方法
    func add(part: String) {
        
    }
}


//定义一个抽象类 为创建一个Product对象的各个部件指定的抽象接口
private class Builder {
    
    func BuildPartOne() {
        
    }
    
    func BuildPartTwo() {
        
    }
    
    func getResult() -> Product {
        return Product()
    }
}

//具体Builder类 实现Builder接口 构造和装配各个部件 用于定义生成一个产品所需要的部件
private class ConcreteBuilderA: Builder {
    
    fileprivate var product = Product()
    
     override func BuildPartOne() {
        //具体实现
        product.add(part: "One")
    }
    
     override func BuildPartTwo() {
        //具体实现
        product.add(part: "Two")
    }
    
    override func getResult() -> Product {
        return product
    }
}

private class ConcreteBuilderB: Builder {
    
    fileprivate var product = Product()
    
    override func BuildPartOne() {
        //具体实现
        product.add(part: "One")
    }
    
    override func BuildPartTwo() {
        //具体实现
        product.add(part: "Two")
    }
    
    override func getResult() -> Product {
        return product
    }
}

//定义一个指挥者 构建一个使用Builder接口的对象 这样客户端不需要知道具体的建造过程
private class Director {
    
    public func Construct(builder: Builder) {
        
        builder.BuildPartOne()
        builder.BuildPartTwo()
    }
}

private class Client {
    
    func main() {
        
        var director = Director()
        var builderA = ConcreteBuilderA()
        var builderB = ConcreteBuilderB()
        
        //指挥者用ConcreteBuilderA的方法来建造产品
        director.Construct(builder: builderA)
        
        var p1 = builderA.getResult()
        
        
        
        
    }
}


