//
//  FoodBarLayer.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit

class FoodBarLayer:Layer {
    
    var foodArray:Array = Array<Ingredient>()
    var maxIngredient = 5;
    
    
    override func didMove() {
        self.color = UIColor.yellow
        self.colorBlendFactor = 1.0
        
        setupFoods()
    }
    
    func setupFoods(){
        
        print(self.size)
        print(self.size.width*0.5)
        
        let ratio = self.size.width*0.4
        let space:CGFloat = 20
        
        for i in 1...maxIngredient {
            let food = Ingredient(color: UIColor.white, size: CGSize(width: ratio, height: ratio) )
            food.anchorPoint = CGPoint(x: 0.5, y:1.0)
            
            food.position.y = -(ratio + space) * CGFloat(i - 1) - ratio
            food.position.x = self.size.width*0.5
            
            foodArray.append(food)
            self.addChild(food)
        }
        
    }
    
}
