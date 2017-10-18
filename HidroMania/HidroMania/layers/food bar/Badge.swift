//
//  Badge.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit

class Badge:SKNode{
    
    private var label:SKLabelNode
    private var circle:SKShapeNode
    
    var number:Int {
        didSet{
            label.text = String(number)
        }
    }
    
    
    init(radius:CGFloat){
        
        label = SKLabelNode(text: "1")
        number = 0
        circle = SKShapeNode(circleOfRadius: radius)
        
        super.init()
        
        circle.strokeColor = SKColor.clear
        circle.glowWidth = 1.0
        circle.fillColor = SKColor.white
        
        label.fontSize = 10
        label.fontName = "AvenirNext-Bold"
        label.fontColor = UIColor.black
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.zPosition = 2
        
        self.addChild(circle)
        self.addChild(label)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
