//
//  AdapterPattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/27.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation
/**
 * 适配器模式
 * !@brief 将一个类的接口转换成客户希望的另外一个接口。Adapter模式使得原本由于接口不兼容而不能一起工作的那些类可以一起工作
 *  @note 系统的数据和行为都正确，但接口不符时，我们应该考虑用适配器，目的是使控制范围之外的一个原有对象与某个接口匹配，适配器模式主要应用于希望复用一些现存的类，但是接口又与复用环境要求不一致的情况
 */

//这是客户所期待的接口。 目标可以是具体的或抽象的类，也可以是接口
private class Target {
    
    public func Request() {
        //发起普通请求
    }
}

//需要适配的类
private class Adaptee {
    
    public func SpecificRequest() {
        //特殊请求
    }
}

//适配器 通过包装一个Adaptee对象 把源接口转换成目标接口
private class Adapter: Target {
    //建立一个私有的Adaptee对象
    private var adaptee: Adaptee = Adaptee()
     override func Request() {
        //这样就可以把表面上调用Request()方法变成实际调用SpecificRequest()
        self.adaptee.SpecificRequest()
    }
}

private class Client {
    
    func main() {
        
        let target: Target = Adapter()
        target.Request()
    }
}
