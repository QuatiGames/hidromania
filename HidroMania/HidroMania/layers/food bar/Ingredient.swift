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
    private var price:Double
    var description:String
    
    init(n:String, t:String, p:Double, d:String){
        name = n
        type = t
        price = p
        description = d
    }
    
    func getPrice() -> Double{
        return price * player.discount
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
