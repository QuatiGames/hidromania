//
//  WaterPathLayer.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit

class WaterPathLayer:Layer {
    
//    var pathPosition = [Int:CGPoint]()
    
    var holes = Array<PlantHole>()
    
    var timeBettweenSpawns:Double = 8
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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            
            for node in self.nodes(at: location){
                if node is Plant{
                    if let p = node as? Plant {
                        if p.isReadyToHarvest {
                            p.harvested = true
                            p.removeFromParent()
                            player.money += 100
                        }
                    }
                }
            }
        }
    }
    
    
    //Food Destroy array
    private var  aux2 = Array<Food>()
    
    override func update(delta: Double) {
        
        for h in holes {
            h.update()
        }
        
        for f in foods {
            
            let f = f as! Food
            
            //iterate holes
            for h in holes {
                //check food
                if (h.checkPlant(f)){
                    f.removeFromParent()
                    aux2.append(f)
                }
            }
            
            if f.isDead {
                aux2.append(f)
            }
            
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
    
    func addPlant(plantType: PlantType) -> Plant {
        let plant = Plant(plantType: plantType, positionOnPath: 1)
        self.addChild(plant)
        
        plant.runIdleAction()
        
        return plant
    }
    
    func configurePoints(){

        holes.append(PlantHole(314.0, 291.000030517578))
        
        holes.append(PlantHole(204.99, 289.5))
        holes.append(PlantHole(92.5, 292.500030517578))
        holes.append(PlantHole(91.5, 196.500015258789))
        holes.append(PlantHole(201.5, 198.500015258789))
        holes.append(PlantHole(309.5, 197.000015258789))
        holes.append(PlantHole(92.0000152587891, 106.5))
        holes.append(PlantHole(200.999984741211, 109.0))
        holes.append(PlantHole(309.0, 107.500015258789))
    }
    
    func createPlant(){
        
        timeBettweenSpawns *=  0.95
        
        if let h = holes.random(){
            
            if h.isEmpty() {
                let plant = addPlant(plantType: PlantType.randomPlantType())
                h.add(plant: plant)
            }
        }
        
        let _ = async(delay: timeBettweenSpawns) {
            self.createPlant()
        }
    }

}

extension Array {
    func random() -> Element?{
        
        if self.count <= 0 {
            return nil
        }
        
        let index = Int(UInt32(self.count).random())
        
        let obj = self[index]
        
        return obj
    }
}
