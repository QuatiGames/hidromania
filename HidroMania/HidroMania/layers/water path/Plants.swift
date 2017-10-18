//
//  Plants.swift
//  HidroMania
//
//  Created by Lucas on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit

enum PlantType: Int{
    case unknown = 0, lettuce, cabbage, chive, parsley
}

enum LevelType: Int{
    case unknown = 0, baby, middle, adult
}

enum MoodType: Int{
    case unknown = 0, sad, neutral, happy
}

class Plant: SKSpriteNode{
    
    var positionOnPath: Int
    var moodType:MoodType
    var foodNeeding:FoodType?
    var levelType: LevelType
    let plantType: PlantType
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, positionOnPath: Int, plantType: PlantType) {
        self.positionOnPath = positionOnPath
        self.plantType = plantType
        self.moodType = MoodType.happy //Starts whith a happy mood
        self.levelType = LevelType.baby //Starts as a baby
        
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defineFoodNeeding() {
        self.foodNeeding = FoodType.randomFoodType()
    }
}
