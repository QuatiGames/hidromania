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
    var selectedObject:SKNode? = nil
    var bench:FoodBench
    var tank:Reservoir
    
    
    override init(size: CGSize) {
        bench = FoodBench(color: UIColor.cyan.withAlphaComponent(0.3), size: CGSize(width: size.width, height: size.height*0.5) )
        bench.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        
        tank = Reservoir(color: UIColor.magenta.withAlphaComponent(0.3), size: CGSize(width: size.width*1.5, height: size.height*0.35))
        tank.anchorPoint = CGPoint(x: 1.0, y:0.0)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove() {
        self.color = UIColor.yellow
        
        bench.position.y = -self.size.height*0.4
        bench.position.x = 0
        self.addChild(bench)
        
        tank.position.y = -self.size.height
        tank.position.x = 0
        self.addChild(tank)
        
        
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
                    touchIngredient(node)
                }
                
//                if node is Food{
//                    touchIngredient(node)
//                }
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if selectedObject != nil{
            
            for t in touches {
                let location = t.location(in: self)
                selectedObject?.position = location
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Add to table
        for t in touches {
            let location = t.location(in: self)
            for node in self.nodes(at: location){
                if node == bench{
                    releaseIngredientOnTable()
                }
                
                if node == tank{
                    releaseFoodOnReservoir()
                }
            }
        }
        
        //Remove ingredient
        selectedObject?.removeFromParent()
        
        selectedObject = nil
    }
    
    
    func releaseIngredientOnTable(){
        if let ingredient = selectedObject as? Ingredient {
            bench.ingredients.append(ingredient)
            print("Adding ingredient")
            
            print("Decreasing number of ingredients")
        }
    }
    
    func releaseFoodOnReservoir(){
        print("Releasing food")
    }
    
    func touchIngredient(_ node:SKNode){
        if let ingredient:Ingredient = node as? Ingredient{
            
            if (selectedObject != nil){
                //Remove other ingredient
                selectedObject?.removeFromParent()
            }
            
            selectedObject = ingredient.newCopy()
        }
    }
    
    func touchFood(_ node:SKNode){
        
        print("touch food")
        
//        if let food:Food = node as? Food{
//            
//            if (selectedObject != nil){
//                //Remove other ingredient
//                selectedObject?.removeFromParent()
//            }
//            
//            selectedObject = food.newCopy()
//        }
    }
}
