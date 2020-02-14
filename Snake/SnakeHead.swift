//
//  SnakeHead.swift
//  Snake
//
//  Created by Vit K on 12.02.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

import UIKit
class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint){
        super.init(atPoint:point)
// категория - голова
        self.physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
// пересекается с телом, яблоком и границей экрана
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple | CollisionCategories.Snake
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
