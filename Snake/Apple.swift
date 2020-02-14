//
//  Apple.swift
//  Snake
//
//  Created by Vit K on 12.02.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

import Foundation
import SpriteKit
// Яблоко
class Apple: SKShapeNode {
    convenience init(position: CGPoint) {
        self.init()
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = UIColor.red
        strokeColor = UIColor.red
        lineWidth = 5
        self.position = position
        // Добавляем физическое тело, совпадающее с изображением яблока
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center:CGPoint(x:5, y:5))
        self.physicsBody?.categoryBitMask = CollisionCategories.Apple
    }
}
