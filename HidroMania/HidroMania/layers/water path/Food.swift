//
//  Food.swift
//  HidroMania
//
//  Created by Lucas on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit

enum FoodType: Int {
    //Enum all the valid recepies from 0 to 19
    case unknown = 0, N, NN, NNN, Mg, MgMg, MgMgMg, S, SS, SSS, K, KK, KKK, P, PP, PPP, KS, KN, KP, MgS
}

class Food: SKSpriteNode {
    let foodType: FoodType
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, foodType: FoodType) {
        self.foodType = foodType
        
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
