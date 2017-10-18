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
        
//        //test food
//        let foodtest = Food(size: CGSize(width: 50, height: 50), foodType: FoodType.N, duration: 2)
//        foodtest.position.x = 436
//        foodtest.position.y = 43
//        self.addChild(foodtest)
//        
//        foodtest.runMovement()
    }
    
    //Don't know if it is necessary
    override init(size: CGSize) {
        
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
