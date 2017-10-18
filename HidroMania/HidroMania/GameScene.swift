//
//  GameScene.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var gameLayer:GameLayer
    
    
    override init(size: CGSize){
        
        //Creating first layer
        gameLayer = GameLayer(size: size)
        
        super.init(size: size)
        
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init(size: UIScreen.main.bounds.size)
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.black
        
        self.addChild(gameLayer)
        gameLayer.didMove()
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameLayer.touchesBegan(touches, with: event)
        
        if let location = touches.first?.location(in: self){
            print(location)
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameLayer.touchesMoved(touches, with: event)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameLayer.touchesEnded(touches, with: event)
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameLayer.touchesCancelled(touches, with: event)
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        gameLayer.update(delta: currentTime)
    }
}
