//
//  MementoPattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/27.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation
/**
 * 备忘录模式
 * !@brief 在不破坏封装性的前提下，捕获一个对象的内部状态，并在该对象在外保存这个状态。这样以后就可将改装对象恢复到原先保存的状态
 */

//发起人类
private class Originator {
    
    //需要保存的属性
    var state: String?
    
    //创建备忘录，将当前需要保存的信息导入并实例化出一个Memento对象
    public func CreateMemento() -> Memento {
        return Memento()
    }
    
    //恢复备份
    public func setMemento(memento: Memento) {
        self.state = memento.state
    }
    
}

//备忘录类
private class Memento {
    
    //备份的属性
    var state: String?
    
    //构造方法 将相关数据导入
    public func Memento(state: String) {
        self.state = state
    }
    
}

//管理者类
private class Caretaker {
    
    //得到或设置备忘录
    var memento: Memento?
}

private class Client {
    
    func main() {
        
        //设置初始状态为On
        let o = Originator()
        o.state = "On"
        
        //保存状态时由于有了很好的封装，可以隐藏Originator的实现细节
        let c = Caretaker()
        c.memento = o.CreateMemento()
        
        //originator改变了状态属性为Off
        o.state = "Off"
        
        //恢复初始状态
        o.setMemento(memento: c.memento!)
    }
}
