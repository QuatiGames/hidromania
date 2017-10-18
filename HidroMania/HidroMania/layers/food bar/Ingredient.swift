//
//  Food.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit

class Ingredient:SKSpriteNode {
    
    var type:String = ""
    
    
    func newCopy() -> Ingredient{
        
        print("new ingredient")
        
        let ingredient = Ingredient(color: self.color, size: self.size)
        ingredient.position = self.position
        ingredient.texture = self.texture
        
        ingredient.type = self.type
        
        //Add same parent
        self.parent?.addChild(ingredient)
        
        return ingredient
    }
}
