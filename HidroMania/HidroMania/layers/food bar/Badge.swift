//
//  Badge.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit


fileprivate let alphaBlank = SKAction.fadeAlpha(to: 1.0, duration: 0.2)

class Badge:SKNode{
    
    var watchingKey:String = ""
    private var label:SKLabelNode
    private var circle:SKShapeNode
    
    fileprivate var obsIndex = -1;
    
    var number:Int {
        didSet{
            
            if (oldValue > number){
                self.runLoseLabel(text: "-\(oldValue - number)")
            }
            
            if (oldValue < number){
                self.runGainLabel(text: "+\(number - oldValue)")
                
            }
            
            if number > 0{
                
                self.circle.fillColor = UIColor.white
                label.text = String(number)
                label.fontColor = UIColor.black
            }else{
                
                if oldValue > 0 {
                    self.alpha = 0.2
                    self.run(alphaBlank)
                    
                    self.circle.fillColor = UIColor.red
                    self.label.fontColor = UIColor.white
                    self.label.text = String(self.number)
                }
            }
            
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
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.zPosition = 2
        
        self.addChild(circle)
        self.addChild(label)
        
        self.zPosition = 100
        
        obsIndex = player.addObserver(obs: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Badge:PlayerObserver {
    
    func update(){
        if let value = player.getValue(of: watchingKey){
            
            self.number = value
        }
    }
    
    func leaveObservatory(){
        player.removeObserver(at: self.obsIndex)
    }
    
}
