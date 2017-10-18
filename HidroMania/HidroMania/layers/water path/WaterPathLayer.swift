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
    var foods = NSMutableArray()
    
    
    
    //Don't know if it is necessary
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func didMove() {
        self.color = UIColor.blue
        
        self.texture = SKTexture(imageNamed: "background")
        
        configurePoints()
        createPlant()
        
        //pathDict[CGPoint(x: , y: )]
        
        //Testing foods
//        self.addFood(foodType: FoodType.N)
        
        async(delay: 2) {
            self.addFood(foodType: .N)
        }
        
        addFood(foodType: .N)
        addFood(foodType: .K)
        addFood(foodType: .KK)
        addFood(foodType: .Mg)
        addFood(foodType: .KS)
        addFood(foodType: .KN)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            
            for node in self.nodes(at: location){
                if node is Plant{
                    if let p = node as? Plant {
                        if p.isReadyToHarvest {
                            p.removeFromParent()
                            player.money += 100
                        }
                    }
                }
            }
        }
    }
    
    private var  aux = Array<Int>()
    private var  aux2 = Array<Food>()
    
    override func update(delta: Double) {
        for f in foods {
            
            let f = f as! Food
            
            if f.isDead {
                aux2.append(f)
            }
            
            for (_, plant) in pathDict{
                
                if let p = plant {
                    
                    if p.checkIfIsInsight(food: f){
                        if f.foodType == p.foodNeeding {
                            f.removeFromParent()
                            foods.remove(f)
                            print("eating food...")
                            p.eat(f)
                        }
                    }
                }
            }
            
        }
        
        
        //Cleaning
        for (key, plant) in pathDict{
            
            if let p = plant {
                if(p.isDead){
                    aux.append(p.key)
                }
            }
        }
        
        for k in aux {
            pathDict[k] = nil
        }
        
        for f in aux2 {
            foods.remove(f)
        }
        
    }
    
    
    func addFood(foodType: FoodType){
        let food = Food(size: CGSize(width: 50, height: 50), foodType: foodType, duration: 2) //Change duration value depending on the player value
        
        //Initial position
        food.position.x = 436
        food.position.y = 43
        
        self.addChild(food)
        foods.add(food)
        food.runMovement()
    }
    
    func addPlant(plantType: PlantType, position:CGPoint) -> Plant {
        let plant = Plant(plantType: plantType, positionOnPath: 1)
        plant.position = position
        self.addChild(plant)
        
        plant.runIdleAction()
        
        return plant
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
        
        let index = Int(UInt32(9).random(1))
        
        if(pathDict[index] == nil){
            if let pos = pathPosition[index]{
                let plant = addPlant(plantType: PlantType.randomPlantType(), position: pos)
                pathDict[index] = plant
                plant.key = index
            }
        }
        
        let _ = async(delay: timeBettweenSpawns) {
            self.createPlant()
        }
    }

}
