//
//  FoodTable.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit


class FoodBench:SKSpriteNode {
    
    var ingredients = Array<Ingredient>()
    var food:Food?
    
    func add(ingredient: Ingredient){
        self.ingredients.append(ingredient)
        
        
    }
}

