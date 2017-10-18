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
    
    var appearAction = SKAction.fadeAlpha(to: 1.0, duration: 0.3)
    
    var hud:HudLayer
    var waterPath:WaterPathLayer
    var foodBar:FoodBarLayer
    var market: MarketLayer
    
    var backgroundShadow = SKSpriteNode(color: UIColor.darkGray.withAlphaComponent(0.9), size: CGSize.zero)


    override init(size:CGSize){
        
        player.lifes = 3
        player.money = 100
        
        let foodBarSize =   CGSize(width: size.width/6, height: size.height)
        let hudSize =       CGSize(width: size.width - foodBarSize.width, height: size.height/12)
        let waterPathSize = CGSize(width: size.width - foodBarSize.width, height: size.height)
        
        hud = HudLayer(size: hudSize)
        hud.position.x = 0
        hud.position.y = size.height - hud.size.height
        hud.zPosition = 2
      
        foodBar = FoodBarLayer(size: foodBarSize)
        foodBar.position.x = hudSize.width
        foodBar.position.y = 0
        foodBar.zPosition = 1
        
        waterPath = WaterPathLayer(size: waterPathSize)
        waterPath.position.x = 0
        waterPath.position.y = 0
        waterPath.zPosition = 0
        
        market = MarketLayer(size: CGSize(width: size.width/2, height: size.height/2 ))
        market.position.x = size.width/2 - market.size.width/2
        market.position.y = size.height/2 - market.size.height/2
        market.zPosition = 2
        
        super.init(size: size)
        
        
        self.addChild(hud)
        hud.didMove()
        
        self.addChild(waterPath)
        waterPath.didMove()
        
        self.addChild(foodBar)
        foodBar.didMove()
        
        backgroundShadow.size = CGSize(width: size.width, height: size.height)
        backgroundShadow.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        backgroundShadow.position.x = 0
        backgroundShadow.position.y = 0
        backgroundShadow.zPosition = 1
        
        backgroundShadow.alpha = 0.0
        
        self.addChild(backgroundShadow)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove() {
        //displayMarket()
    }
    
    func displayMarket(){
        backgroundShadow.run(appearAction)
        self.addChild(market)
        market.didMove()
    }
    
    
    override func update(delta:Double){
        super.update(delta: delta)
        waterPath.update(delta: delta)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        foodBar.touchesBegan(touches, with: event)
        hud.touchesBegan(touches, with: event)
        waterPath.touchesBegan(touches, with: event)
        market.touchesBegan(touches, with: event)
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
