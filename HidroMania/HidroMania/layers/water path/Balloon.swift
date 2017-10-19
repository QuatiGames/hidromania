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
    
    init(foodType: FoodType) {
        self.foodType = foodType
        self.foodImage = Food(size: CGSize(width: 20, height: 20), foodType: foodType)
        let size = CGSize.init(width: 50, height: 50)
        let color = UIColor.clear
        let texture = SKTexture(imageNamed: "balloon")
        
        super.init(texture: texture, color: color, size: size)
        
        self.addChild(self.foodImage!)
        
        self.foodImage?.zPosition = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
