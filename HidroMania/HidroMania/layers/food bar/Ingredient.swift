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

enum IngredientType: Int{
    case unknow = 0, N, Mg, S, K, P
}


class Ingredient:SKSpriteNode {
    
    var data:IngredientData
    
    init(color: UIColor, size: CGSize, data: IngredientData) {
        self.data = data
        let texture = SKTexture(imageNamed: data.type)
        
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func newCopy() -> Ingredient{
        
        let ingredient = Ingredient(color: self.color, size: self.size, data: self.data)
        ingredient.position = self.position
        ingredient.texture = self.texture
        
        //Add same parent
        self.parent?.addChild(ingredient)
        
        return ingredient
    }
}
