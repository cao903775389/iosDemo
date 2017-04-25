//
//  AppearancePattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/23.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation
/**
 * 外观模式
 * !@brief 为子系统中的一组接口提供一个一致的界面，此模式定义了一个高层接口，这个接口使得这一子系统更加容易使用
 */

//具体的子系统
private class SubSystemOne {
    
    public func methodOne() {
        //子系统的方法一
    }
}

private class SubSystemTwo {
    
    public func methodTwo() {
        //子系统的方法二
    }
}

private class SubSystemThree {
    
    public func methodThree() {
        //子系统的方法三
    }
}

//外观类
private class Facade {
    
    var one: SubSystemOne?
    
    var two: SubSystemTwo?
    
    var three: SubSystemThree?
    
    //定义一个对外界暴露的外观方法
    
    //初始化
    public func Facade() {
        one = SubSystemOne()
        two = SubSystemTwo()
        three = SubSystemThree()
    }
    
    //外观方法A
    public func MethodA() {
        one?.methodOne()
        two?.methodTwo()
        three?.methodThree()
    }
    
    //外观方法B
    public func MethodB() {
        one?.methodOne()
    }
    
}
