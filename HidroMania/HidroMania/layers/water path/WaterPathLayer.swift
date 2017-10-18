//
//  WaterPathLayer.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit

class WaterPathLayer:Layer {
    
    var pathArray:Array<Plant>?
    
    override func didMove() {
        self.color = UIColor.blue
        
        self.texture = SKTexture(imageNamed: "background")
        
        
        //Testing foods
//        self.addFood(foodType: FoodType.N)
        
        //Testing plants
        self.addPlant(plantType: PlantType.cabbage)
        
    }
    
    //Don't know if it is necessary
    override init(size: CGSize) {
        
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addFood(foodType: FoodType){
        let food = Food(size: CGSize(width: 50, height: 50), foodType: foodType, duration: 2) //Change duration value depending on the player value
        
        //Initial position
        food.position.x = 436
        food.position.y = 43
        
        self.addChild(food)
        food.runMovement()
    }
    
    func addPlant(plantType: PlantType) {
        let plant = Plant(plantType: plantType, positionOnPath: 1)
        
        plant.position.x = 88
        plant.position.y = 109
        
        self.addChild(plant)
        
        
        plant.runIdleAction()
        
        plant.defineFoodNeeding()
        
        let action = SKAction.sequence([SKAction.wait(forDuration: 3),
                                        SKAction.run {
                                            plant.runEating()
            },
                                        SKAction.wait(forDuration: 5),
                                        SKAction.run {
                                            plant.defineFoodNeeding()
            }])
        
        self.run(action)
    }
}
