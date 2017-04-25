//
//  DelegatePattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/23.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation
/**
 * 代理模式
 * !@brief 为其他对象提供一种代理以控制对这个对象的访问
 */

//定义了一个抽象接口 或者抽象类
private class Subject {
    
    func request() {
        
    }
}

private class RealSubject: Subject {
    
     override func request() {
        //真正的请求发起者
    }
}

private class Proxy: Subject {
    
    var realSubject: RealSubject?
    
     override func request() {
        //保存一个真正请求发起者的引用 以便访问实体
        realSubject?.request()
    }
}

private class Client {
    
    func main() {
        
        let proxy = Proxy()
        proxy.request()
    }
}
