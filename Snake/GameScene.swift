//
//  GameScene.swift
//  Snake
//
//  Created by Vit K on 12.02.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

import SpriteKit
import GameplayKit

extension GameScene: SKPhysicsContactDelegate {
    // Добавляем метод отслеживания начала столкновения
    func didBegin(_ contact: SKPhysicsContact) {
    // логическая сумма масок соприкоснувшихся объектов
            let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
    // вычитаем из суммы голову змеи, и у нас остается маска второго объекта
            let collisionObject = bodyes ^ CollisionCategories.SnakeHead
    // проверяем, что это за второй объект
            switch collisionObject {
            case CollisionCategories.Apple: // проверяем, что это яблоко
    // яблоко – это один из двух объектов, которые соприкоснулись. Используем тернарный оператор, чтобы вычислить, какой именно
                let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
    // добавляем к змее еще одну секцию
                snake?.addBodyPart()
    // удаляем съеденное яблоко со сцены
                apple?.removeFromParent()
    // создаем новое яблоко
                createApple()
            case CollisionCategories.EdgeBody: // проверяем, что это стенка экрана
                snake?.removeFromParent()
                snake = nil
                snake = Snake(atPoint: CGPoint(x: view?.scene!.frame.midX ?? 0, y: view?.scene!.frame.midY ?? 0))
                self.addChild(snake!)
            // соприкосновение со стеной будет домашним заданием
            default:
                break
            }
        }
}
// Категория пересечения объектов
struct CollisionCategories{
// Тело змеи
    static let Snake: UInt32 = 0x1 << 0
// Голова змеи
    static let SnakeHead: UInt32 = 0x1 << 1
// Яблоко
    static let Apple: UInt32 = 0x1 << 2
// Край сцены (экрана)
    static let EdgeBody:   UInt32 = 0x1 << 3
}

class GameScene: SKScene {
    var snake: Snake?
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.darkGray
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        view.showsPhysics = true
        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX+30, y: view.scene!.frame.minY+30)
        counterClockwiseButton.fillColor = UIColor.gray
        counterClockwiseButton.strokeColor = UIColor.gray
        counterClockwiseButton.lineWidth = 10
        counterClockwiseButton.name = "counterClockwiseButton"
        counterClockwiseButton.zPosition = 2
        self.addChild(counterClockwiseButton)
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwiseButton.position = CGPoint(x: view.scene!.frame.maxX-80, y: view.scene!.frame.minY+30)
        clockwiseButton.fillColor = UIColor.gray
        clockwiseButton.strokeColor = UIColor.gray
        clockwiseButton.lineWidth = 10
        clockwiseButton.name = "clockwiseButton"
        clockwiseButton.zPosition = 2
        self.addChild(clockwiseButton)
        createApple()
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        self.physicsWorld.contactDelegate = self
        // устанавливаем категорию взаимодействия с другими объектами
                self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        // устанавливаем категории, с которыми будут пересекаться края сцены
                self.physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
    }
    
    // вызывается при нажатии на экран
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // перебираем все точки, куда прикоснулся палец
        for touch in touches {
            // определяем координаты касания для точки
            let touchLocation = touch.location(in: self)
            // проверяем, есть ли объект по этим координатам, и если есть, то не наша ли это кнопка
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton" else {
                    return
            }
            // если это наша кнопка, заливаем ее зеленым
            touchedNode.fillColor = .green
            // определяем, какая кнопка нажата, и поворачиваем в нужную сторону
            if touchedNode.name == "counterClockwiseButton" {
                snake!.moveCounterClockwise()
            } else if touchedNode.name == "clockwiseButton" {
                snake!.moveClockwise()
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton" else {
                    return
            }
            touchedNode.fillColor = UIColor.gray
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        snake!.move()
    }
    func createApple(){
        let randX  = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX-5)) + 1)
        let randY  = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY-5)) + 1)
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
    }
    
}
