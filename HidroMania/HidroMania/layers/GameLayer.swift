//
//  GameLayer.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit

class GameLayer:Layer{
    
    var hud:HudLayer
    var waterPath:WaterPathLayer
    var foodBar:FoodBarLayer


    override init(size:CGSize){
        let foodBarSize =   CGSize(width: size.width/6, height: size.height)
        let hudSize =       CGSize(width: size.width - foodBarSize.width, height: size.height/12)
        let waterPathSize = CGSize(width: size.width - foodBarSize.width, height: size.height)
        
        hud = HudLayer(size: hudSize)
        hud.position.x = 0
        hud.position.y = size.height
        hud.zPosition = 2
        
        foodBar = FoodBarLayer(size: foodBarSize)
        foodBar.position.x = hudSize.width
        foodBar.position.y = size.height
        foodBar.zPosition = 1
        
        waterPath = WaterPathLayer(size: waterPathSize)
        waterPath.position.x = 0
        waterPath.position.y = size.height
        waterPath.zPosition = 0
        
        super.init(size: size)
        
        
        self.addChild(hud)
        hud.didMove()
        
        self.addChild(waterPath)
        waterPath.didMove()
        
        self.addChild(foodBar)
        foodBar.didMove()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove() {
        
    }
    
    
    override func update(delta:Double){
        super.update(delta: delta)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
}
