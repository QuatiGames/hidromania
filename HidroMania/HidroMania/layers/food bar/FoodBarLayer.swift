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
    var selectedIngredient:Ingredient? = nil
    var bench:FoodBench
    
    override init(size: CGSize) {
        bench = FoodBench(color: UIColor.cyan, size: CGSize(width: size.width, height: size.height*0.35) )
        bench.alpha = 0.3
        bench.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove() {
        self.color = UIColor.yellow
        
        bench.position.y = -self.size.height/2
        bench.position.x = 0
        
        self.addChild(bench)
        
        setupFoods()
    }
    
    
    func setupFoods(){
        
        let ratio = self.size.width*0.4
        let space:CGFloat = self.size.width*0.1
        
        for i in 1...maxIngredient {
            let food = Ingredient(color: UIColor.white, size: CGSize(width: ratio, height: ratio) )
            food.anchorPoint = CGPoint(x: 0.5, y:1.0)
            
            food.position.y = -(ratio + space) * CGFloat(i - 1) - ratio
            food.position.x = self.size.width*0.5
            
            foodArray.append(food)
            self.addChild(food)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches {
            let location = t.location(in: self)
            
            for node in self.nodes(at: location){
                if node is Ingredient{
                    if let ingredient:Ingredient = node as? Ingredient{
                        
                        if (selectedIngredient != nil){
                            //Remove other ingredient
                            selectedIngredient?.removeFromParent()
                        }
                        
                        selectedIngredient = ingredient.newCopy()
                    }
                }
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if selectedIngredient != nil{
            
            for t in touches {
                let location = t.location(in: self)
                selectedIngredient?.position = location
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Add to table
        for t in touches {
            let location = t.location(in: self)
            for node in self.nodes(at: location){
                if node == bench{
                    if let ingredient = selectedIngredient {
                        bench.ingredients.append(ingredient)
                        print("Adding ingredient")
                    }
                }
            }
        }
    
    
        
        //Remove ingredient
        selectedIngredient?.removeFromParent()
    }
    
}
