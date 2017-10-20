//
//  PlantRole.swift
//  HidroMania
//
//  Created by Lucas Araujo on 19/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit


class PlantHole {
    private var currentPlant:Plant? {
        didSet{
            if currentPlant != nil{
                print("adding plant: \(currentPlant!.plantType)")
            }else{
                print("removing plant")
            }
        }
    }
    var position:CGPoint
    
    init(_ x: CGFloat, _ y: CGFloat){
        position = CGPoint(x: x, y: y)
    }
    
    func isEmpty() -> Bool {
        return currentPlant == nil
    }
    
    func update(){
        
        if let p = currentPlant {
            if p.isDead || p.harvested{
                p.removeFromParent()
                currentPlant = nil
            }
        }
    }
    
    func add(plant: Plant){
        if isEmpty() {
            currentPlant = plant
            plant.position = self.position
        }
    }
    
    func checkPlant(_ f:Food) -> Bool{
        
        if let p = currentPlant {
            
            if p.isDead == false  {
            
                if p.checkIfIsInsight(food: f){
                    if f.foodType == p.foodNeeding {
                        print("eating food...")
                        p.eat(f)
                        return true
                    }
                }
            }
        }
        
        return false
    }
}
