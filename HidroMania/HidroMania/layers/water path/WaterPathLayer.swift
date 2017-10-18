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
        
        self.texture = SKTexture(imageNamed: "background.png")
    }
    
    //Don't know if it is necessary
    override init(size: CGSize) {
        
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
