//
//  CompositePattern.swift
//  DesignPatternDemo
//
//  Created by 逢阳曹 on 2017/3/27.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

import Foundation
/**
 * 组合模式
 * !@brief 将对象组合成树形结构以表示 部分-整体的层次结构，组合模式使得用户对单个对象和组合对象的使用具有一致性
 */

//为组合中的对象声明接口 ，在适当情况下，实现所有类共有接口的默认行为。声明一个接口用于访问和管理的子部件
//这是一个抽象类或者抽象接口
private class Component {
    private var name: String?
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    //定义组合中所有类的公共接口
    public func Add(c: Component) {
        
    }
    
    public func Remove(c: Component) {
        
    }
    
    public func Display() {
        //展示当前节点
    }
}

//声明叶节点对象 叶节点没有子节点
private class Leaf: Component {
    
     override func Add(c: Component) {
        //无法向子节点中添加组件
    }
    
     override func Remove(c: Component) {
        //无法移除子节点中的组件
    }
    
     override func Display() {
        
    }
}

//Composite定义有枝节点行为，用来存储子部件，在Component接口中实现与子部件有关的操作 比如增加和删除
private class Composite: Component {
    
    private var list: [Component]?
    
     override func Add(c: Component) {
        list?.append(c)
    }
    
     override func Remove(c: Component) {
        //获取c的索引 然后移除
        list?.remove(at: 0)
    }
    
     override func Display() {
        
        for item in list! {
            item.Display()
        }
    }
}

private class Client {
    
    func main() {
        //生成树根root 跟上长出两叶LeafA 和LeafB
        let root = Composite(name: "root")
        root.Add(c: Leaf(name: "Leaf A"))
        root.Add(c: Leaf(name: "Leaf B"))
        
        //根上长出分支CompositeX 分支上也有两叶子LeafXA和LeafXB
        let comp = Composite(name: "Composite X")
        comp.Add(c: Leaf(name: "Leaf XA"))
        comp.Add(c: Leaf(name: "Leaf XB"))
        root.Add(c: comp)
        
        root.Add(c: comp)
        
        //在Compsite X上在长出分支Composite XY, 分枝上也有两叶LeafXYA 和LeafXYB
        let comp2 = Composite(name: "Composite XY")
        comp2.Add(c: Leaf(name: "Leaf XYA"))
        comp2.Add(c: Leaf(name: "Leaf XYB"))
        comp.Add(c: comp2)
        
        root.Add(c: Leaf(name: "Leaf C"))
        
        let leaf = Leaf(name: "Leaf D")
        root.Add(c: leaf)
        root.Remove(c: leaf)
        
        root.Display()
    }
}

