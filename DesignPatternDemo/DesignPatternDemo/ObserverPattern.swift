//
//  ObserverPattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/24.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation
/**
 * 观察者模式
 * !@brief 定义了一种一对多的依赖关系，让多个观察者对象同时监听某一个主题对象。这个主题对象在状态发生变化时，会通知所有观察者对象，使它们能够自动更新自己。
 */

//定义一个抽象类或者接口实现 它把所有对观察者对象的引用保存在一个聚集里
private class Subject {
    
    private var observers: [Observer] = []
    
    //增加观察者
    public func attach(observer: Observer) {
        observers.append(observer)
    }
    
    //移除观察者
    public func detach(observer: Observer) {
        observers.remove(at: 0)
    }
    
    //通知
    public func notify() {
        for observer in observers {
            observer.update()
        }
    }
    
}

//抽象观察者 为所有的具体观察者定义一个接口，在得到主题的通知时更新自己。这个接口叫做更新接口，抽象观察者一般用一个抽象类或者一个接口实现
private class Observer {
    
    func update() {
        
    }
}

//具体的通知者类
private class ConcreteSubject: Subject {
    
    //具体被观察者状态 也就是被观察的属性
    var subjectState: String?
    
    //
}


//具体的观察者类
private class ConcreteObserver: Observer {
    
    //观察的属性名
    private var name: String?
    
    private var observerState: String?
    
    private var subject: ConcreteSubject?
    
    convenience init(subject: ConcreteSubject, name: String) {
        self.init()
        self.subject = subject
        self.name = name
    }
    
     override func update() {
        //更新状态和被观察者一致
        observerState = subject?.subjectState
    }
}

private class Client {
    
    func main() {
        let s = ConcreteSubject()
        
        s.attach(observer: ConcreteObserver(subject: s, name: "frame"))
        s.attach(observer: ConcreteObserver(subject: s, name: "color"))
        
        s.subjectState = "ABC"
        s.notify()
    }
}















