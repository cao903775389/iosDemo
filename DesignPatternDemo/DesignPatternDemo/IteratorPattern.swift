//
//  IteratorPattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/27.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation
/**
 * 迭代器模式
 * !@brief 提供一种方法顺序访问一个聚合对象中各个元素，而又不暴露该对象的内部表示
 */

//迭代器抽象类或接口
private class Iterator {
    
    //用于定义得到开始对象、下一对象、判断是否到结尾、当前对象等抽象方法
    public func First()-> Any {
        return "0"
    }
    
    public func Next()-> Any {
        return "1"
    }
    
    public func IsDone()-> Bool {
        return false
    }
    
    public func CurrentItem()-> Any {
        return "0"
    }
}

//聚集抽象类
private class Aggregate {
    
    public func CreateIterator() -> Iterator {
        return Iterator()
    }
}

//具体迭代器类
private class ConcreteIterator: Iterator {
    private var aggregate: Aggregate?
    private var current = 0
    
    convenience init(aggregate: Aggregate) {
        self.init()
        self.aggregate = aggregate
    }
    
     override func First()-> Any {
//        self.aggregate?[0]
        return "0"
    }
    
     override func Next() -> Any {
//        self.current += 1
//        var ret: Any?
//        if self.current< aggregate.count {
//            ret = aggregate?[current]
//        }
//        return ret
        return "1"
    }
    
     override func IsDone()-> Bool {
//        return self.current >= aggregate.count ? true : false
        return true
    }
    
     override func CurrentItem()-> Any {
//        return aggregate[current]
        return "0"
    }
}

//具体聚合类
private class ConcreteAggregate: Aggregate {
    
    private var items: [Any] = []
    
    override func CreateIterator() -> Iterator {
        return ConcreteIterator(aggregate: self)
    }
    
    
}







