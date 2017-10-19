//
//  HudLayer.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit



class HudLayer:Layer {
    
    var market:SKSpriteNode = SKSpriteNode(color: UIColor.lightGray.withAlphaComponent(0.3), size: CGSize.zero)
    var moneyLabel:Money = Money(text: "")
    var gameLayer:GameLayer?
    
    
    
    override func didMove() {
        
        moneyLabel.text = "$ \(player.money)"
        moneyLabel.fontSize = 15
        moneyLabel.fontName = "AvenirNext-Bold"
        moneyLabel.horizontalAlignmentMode = .left
        moneyLabel.verticalAlignmentMode = .center
        moneyLabel.position.x = 80
        moneyLabel.position.y = 20
        
        player.addObserver(obs: moneyLabel)
        
        self.addChild(market)
        self.addChild(moneyLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
}



class Money:SKLabelNode, PlayerObserver {
    func update(){
        self.text = "$ \(player.money)"
    }
    
    func leaveObservatory(){
        
    }
}


