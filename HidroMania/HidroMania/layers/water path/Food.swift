//
//  Food.swift
//  HidroMania
//
//  Created by Lucas on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit

enum FoodType: Int {
    //Enum all the valid recepies from 0 to 19
    case unknown = 0, N, NN, NNN, Mg, MgMg, MgMgMg, S, SS, SSS, K, KK, KKK, P, PP, PPP, KS, KN, KP, MgS
    
    //Find maxium enum value
    private static let _count: FoodType.RawValue = {
        var maxValue: Int = 0
        while let _ = FoodType(rawValue: maxValue){
            maxValue += 1
        }
        
        return maxValue - 1
    }()
    
    //return a random FoodType value
    static func randomFoodType() -> FoodType {
        //Pick and return a new value
        let rand = arc4random_uniform(UInt32(_count))
        
        return FoodType(rawValue: Int(rand))!
    }
}

let MAXFOODTYPE = 19

class Food: SKSpriteNode {
    let foodType: FoodType
//    var moveOnWaterPath: SKAction? //Only for the food that move on path
    var bubble: SKSpriteNode? //Only for the food that move on path
    var duration: TimeInterval = 0 //Only for the food that move on path
    
    //Init with FoodType
    init(size: CGSize, foodType: FoodType) {
        self.foodType = foodType
        
        //Define food sprite accourding to the FoodType
        let imageName = "smallFood\(self.foodType.rawValue)"
        let texture = SKTexture(imageNamed: imageName)
        //print("Food log: \(imageName)")
        
        super.init(texture: texture, color: UIColor.clear, size: size)
    }
    
    //Init food to move on water path
    convenience init(size: CGSize, foodType: FoodType, duration: TimeInterval){
        self.init(size: size, foodType: foodType)
        
        self.duration = duration
        //Add bubble
//        self.bubble = SKSpriteNode(imageNamed: "bubble")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Describe de movement on water path
    func runMovement(){
        //Define points to move
        let moveSequence = SKAction.sequence([SKAction.move(to: CGPoint(x: 436, y: 274), duration: self.duration),
                                              SKAction.move(to: CGPoint(x: 21, y: 278), duration: self.duration),
                                              SKAction.move(to: CGPoint(x: 21, y: 186), duration: self.duration/2),
                                              SKAction.move(to: CGPoint(x: 385, y: 182), duration: self.duration),
                                              SKAction.move(to: CGPoint(x: 385, y: 90), duration: self.duration/2),
                                              SKAction.move(to: CGPoint(x: 22, y: 90), duration: self.duration),
                                              SKAction.move(to: CGPoint(x: 22, y: 40), duration: self.duration/3),
                                              SKAction.move(to: CGPoint(x: 436, y: 43), duration: self.duration)])
        
        self.run(SKAction.repeatForever(moveSequence))
    }
}
