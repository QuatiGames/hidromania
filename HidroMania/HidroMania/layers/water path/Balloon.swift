//
//  Balloon.swift
//  HidroMania
//
//  Created by Lucas on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit

class Balloon: SKSpriteNode{
    let foodType: FoodType
    var foodImage: SKSpriteNode?
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, foodType: FoodType) {
        self.foodType = foodType
        self.foodImage = Food(size: CGSize(width: 20, height: 20), foodType: foodType)
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
