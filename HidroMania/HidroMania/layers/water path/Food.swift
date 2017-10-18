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
    
    //Find maxium enum value
    private static let _count: FoodType.RawValue = {
        var maxValue: Int = 1
        while let _ = FoodType(rawValue: maxValue){
            maxValue += 1
        }
        
        return maxValue
    }()
    
    //return a random FoodType value
    static func randomFoodType() -> FoodType {
        //Pick and return a new value
        let rand = arc4random_uniform(UInt32(_count))
        
        return FoodType(rawValue: Int(rand))!
    }
}

let MAXFOODTYPE = 19

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
