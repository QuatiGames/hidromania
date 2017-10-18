//
//  GameLayer.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit


//Singleton For data access
let player = Player()

class GameLayer:Layer{
    
    var hud:HudLayer
    var waterPath:WaterPathLayer
    var foodBar:FoodBarLayer


    override init(size:CGSize){
        
        player.lifes = 3
        player.money = 100
        
        let foodBarSize =   CGSize(width: size.width/6, height: size.height)
        let hudSize =       CGSize(width: size.width - foodBarSize.width, height: size.height/12)
        let waterPathSize = CGSize(width: size.width - foodBarSize.width, height: size.height - hudSize.height)
        
        hud = HudLayer(size: hudSize)
        hud.position.x = 0
        hud.position.y = size.height - hud.size.height
        
        waterPath = WaterPathLayer(size: waterPathSize)
        waterPath.position.x = 0
        waterPath.position.y = 0
        
        foodBar = FoodBarLayer(size: foodBarSize)
        foodBar.position.x = hudSize.width
        foodBar.position.y = 0
        
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
        foodBar.touchesBegan(touches, with: event)
        hud.touchesBegan(touches, with: event)
        waterPath.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        foodBar.touchesMoved(touches, with: event)
        hud.touchesMoved(touches, with: event)
        waterPath.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        foodBar.touchesEnded(touches, with: event)
        hud.touchesEnded(touches, with: event)
        waterPath.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        foodBar.touchesCancelled(touches, with: event)
        hud.touchesCancelled(touches, with: event)
        waterPath.touchesCancelled(touches, with: event)
    }
    
}
