//
//  Utils.swift
//  HidroMania
//
//  Created by Lucas Araujo on 22/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit


extension SKNode {
    
    func runLoseLabel(text:String){
        let label = createFeedbackLabel(text, UIColor.red)
//        self.addChild(label)
        label.runFeedbackAnimation(-10)
        
        print("Run lose label")
        
        self.parent?.addChild(label)
        
    }
    
    func runGainLabel(text:String){
        let label = createFeedbackLabel(text, UIColor.green)
//        self.addChild(label)
        self.parent?.addChild(label)
        label.runFeedbackAnimation(10)
        
        print("Run lose label")
    }
    
    fileprivate func createFeedbackLabel(_ text:String, _ color:UIColor) -> SKLabelNode{
        let label = SKLabelNode(text: text)
        label.fontSize = 16
        label.fontColor = color
        label.fontName = "AvenirNext-Bold"
        
        label.position = self.position
        
        label.position.y += -20
        label.zPosition = 200
        
        return label
    }
    
    
}

extension SKLabelNode {
    fileprivate func runFeedbackAnimation(_ y: CGFloat){
        let sequence = SKAction.sequence([
            SKAction.moveBy(x: 0.0, y: y, duration: 0.4),
            SKAction.fadeOut(withDuration: 0.8)
            ])
        
        self.run(sequence, completion: {
            self.removeFromParent();
        })
    }
}

