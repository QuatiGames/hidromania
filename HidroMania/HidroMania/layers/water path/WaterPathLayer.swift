//
//  WaterPathLayer.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit

class WaterPathLayer:Layer {
    
    var pathPosition = [Int:CGPoint]()
    var pathDict = [Int:Plant?]()
    var timeBettweenSpawns:Double = 2
    
    override func didMove() {
        self.color = UIColor.blue
        
        self.texture = SKTexture(imageNamed: "background")
        
        configurePoints()
        createPlant()
        
        //pathDict[CGPoint(x: , y: )]
        
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
    
    func configurePoints(){
        
        pathPosition = [
            1:createPT(314.0, 291.000030517578),
            2:createPT(204.999984741211, 289.500030517578),
            3:createPT(92.5, 292.500030517578),
            4:createPT(91.5, 196.500015258789),
            5:createPT(201.5, 198.500015258789),
            6:createPT(309.5, 197.000015258789),
            7:createPT(92.0000152587891, 106.5),
            8:createPT(200.999984741211, 109.0),
            9:createPT(309.0, 107.500015258789)
        ]
    }
    
    func createPT(_ x:Double,_ y:Double) -> CGPoint{
        return CGPoint(x: x, y: y)
    }
    
    func createPlant(){
        
        print("new plant")
        
        async(delay: timeBettweenSpawns) {
            self.createPlant()
        }
    }
}
