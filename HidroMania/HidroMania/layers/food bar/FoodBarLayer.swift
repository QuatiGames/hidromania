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
    var trash:SKSpriteNode
    
    
    override init(size: CGSize) {
        bench = FoodBench(color: UIColor.cyan.withAlphaComponent(0.3), size: CGSize(width: size.width, height: size.height*0.45) )
        bench.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        
        tank = Reservoir(color: UIColor.magenta.withAlphaComponent(0.3), size: CGSize(width: size.width*1.5, height: size.height*0.25))
        tank.anchorPoint = CGPoint(x: 1.0, y:0.0)
        
        trash = SKSpriteNode(color: UIColor.red.withAlphaComponent(0.5), size: CGSize(width: size.width*0.5, height: size.height*0.15))
        trash.anchorPoint = CGPoint(x: 1.0, y:1.0)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove() {
        self.color = UIColor.yellow
        
        bench.position.y = self.size.height*0.5
        bench.position.x = 0
        self.addChild(bench)
        
        tank.position.y = 0
        tank.position.x = 0
        self.addChild(tank)
        
        trash.position.y = self.size.height*0.9
        trash.position.x = 0
        self.addChild(trash)
        
        
        setupFoods()
    }
    
    
    func setupFoods(){
        
        let ratio = self.size.width*0.4
        let space:CGFloat = self.size.width*0.15
        
        for i in 1...maxIngredient {
            let food = Ingredient(color: UIColor.lightGray, size: CGSize(width: ratio, height: ratio) )
            food.type = "type\(i)"
            food.anchorPoint = CGPoint(x: 0.5, y:1.0)
            
            food.position.y = (ratio + space) * CGFloat(i - 1) + ratio*2
            food.position.x = self.size.width*0.5
            
            let badge = Badge(radius: food.size.width/4)
            badge.position.x = food.size.width/2
            badge.position.y = 0
            food.addChild(badge)
            
            badge.watchingKey = food.type
            badge.update()
            
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
                
                if node == trash {
                    dumpFood()
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
            player.change(ingredientType: ingredient.type, value: -1)
        }
    }
    
    func releaseFoodOnReservoir(){
        print("Releasing food")
    }
    
    func touchIngredient(_ node:SKNode){
        
        if let ingredient:Ingredient = node as? Ingredient{
            
            // check ingredient amout
            if let amount = player.getValue(of: ingredient.type){
                
                if amount > 0 {
            
                    if (selectedObject != nil){
                        //Remove other ingredient
                        selectedObject?.removeFromParent()
                    }
                    
                    selectedObject = ingredient.newCopy()
                }
            }
        }
    }
    
    func dumpFood(){
        print("dumb food")
        bench.ingredients.removeAll()
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
