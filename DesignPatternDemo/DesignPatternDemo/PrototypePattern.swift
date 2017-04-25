//
//  PrototypePattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/23.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation
/**
 * 原型模式
 * !@brief 用原型实例指定创建对象的种类，并且通过拷贝这些原型创建新的对象
 */

//定义一个抽象的原型类
private class Prototype: NSCopying {
    
    private var id: String?
    
    //抽象克隆接口
    public func Clone() -> Prototype {
        return self
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

//具体的原型类1
private class ConcretePrototype1: Prototype {
    
    override func Clone() -> Prototype {
        return self.copy(with: nil) as! Prototype
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        return super.copy(with: zone)
    }
}

private class Client {
    
    func main() {
        
        var p1 = ConcretePrototype1()
        p1 = p1.Clone() as! ConcretePrototype1
        
    }
}
