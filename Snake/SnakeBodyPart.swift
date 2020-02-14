//
//  SnakeBodyPart.swift
//  Snake
//
//  Created by Vit K on 12.02.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

import UIKit
import SpriteKit
class SnakeBodyPart: SKShapeNode {
    let diameter = 10.0
    // добавляем конструктор
    init (atPoint point: CGPoint){
        super.init()
   // рисуем круглый элемент
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: CGFloat(diameter), height: CGFloat(diameter))).cgPath
   // цвет рамки и заливки зеленый
        fillColor = UIColor.yellow
        strokeColor = UIColor.yellow
   // ширина рамки 5 поинтов
        lineWidth = 5
   // размещаем элемент в переданной точке
        self.position = point
        // Создаем физическое тело
                self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diameter - 4), center: CGPoint(x: 5, y:5))
        // Может перемещаться в пространстве
                self.physicsBody?.isDynamic = true
        // Категория - змея
                self.physicsBody?.categoryBitMask = CollisionCategories.Snake
        // пересекается с границами экрана и яблоком
                self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
