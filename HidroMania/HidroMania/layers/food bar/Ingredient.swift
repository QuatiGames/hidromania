//
//  Food.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit

struct IngredientData{
    var name:String
    var type:String //mudar enum
    var price:Int
    var description:String
    
    init(n:String, t:String, p:Int, d:String){
        self.name = n
        self.type = t
        self.price = p
        self.description = d
    }
}


class Ingredient:SKSpriteNode {
    
    var type:String = ""
    
    
    func newCopy() -> Ingredient{
        
        let ingredient = Ingredient(color: self.color, size: self.size)
        ingredient.position = self.position
        ingredient.texture = self.texture
        
        ingredient.type = self.type
        
        //Add same parent
        self.parent?.addChild(ingredient)
        
        return ingredient
    }
}
