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
//
//        self.run(SKAction.sequence([SKAction.wait(forDuration: 1),
//                                    SKAction.run {
//            self.addFood(foodType: FoodType.N)
//            },
//                                    SKAction.wait(forDuration: 1),
//                                    SKAction.run {
//            self.addFood(foodType: FoodType.N)
//            }]))
        
        //Testing plant
        let plant = Plant(plantType: PlantType.parsley, color: UIColor.clear, positionOnPath: 1)
//        print("\(plant.levelType)")
        plant.position.x = 88
        plant.position.y = 109
        self.addChild(plant)
        plant.levelUp()
        plant.levelUp()
//        plant.levelUp()
//        plant.levelUp()
//        plant.defineMood(moodType: MoodType.neutral)
//        plant.runIdleAction()
//        let bouncing = SKAction.sequence([SKAction.resize(toWidth: 50, height: 120, duration: 1),
//                                          SKAction.resize(toWidth: 100, height: 100, duration: 1)])
//        plant.run(SKAction.repeatForever(bouncing))
            plant.runDeath()
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
    
    func addPlant() {
        
    }
}
