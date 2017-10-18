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
        
        super.init(texture: texture, color: color, size: size)
        
        self.defineFoodImageOf(foodType: self.foodType)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defineFoodImageOf(foodType: FoodType){
        let imageName = "smallFood\(self.foodType).png"
        
        self.foodImage = SKSpriteNode.init(texture: SKTexture(imageNamed: imageName), color: UIColor.magenta.withAlphaComponent(0.3), size: CGSize.init(width: 10, height: 10))
    }
}
