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
    
    //Find maxium enum value
    private static let _max: LevelType.RawValue = {
        var maxValue: Int = 0
        while let _ = LevelType(rawValue: maxValue){
            maxValue += 1
        }
        
        return maxValue - 1
    }()
    
    //Return te next element of the enum
    static func nextLevelTypeOf(levelType: LevelType.RawValue) -> LevelType {
        var next = levelType
        if next < LevelType._max {
            next += 1
        }
        
        return LevelType(rawValue: next)!
    }
}

enum MoodType: Int{
    case unknown = 0, sad, neutral, happy
}

class Plant: SKSpriteNode{
    let normalSize: CGSize = CGSize.init(width: 100, height: 100)
    
    var positionOnPath: Int
    var moodType:MoodType
    var moodSprite:SKSpriteNode
    var foodNeeding:FoodType?
    var levelType: LevelType
    let plantType: PlantType
    var isReadyToHarvest: Bool
    
    init(plantType: PlantType, positionOnPath: Int) {
        self.positionOnPath = positionOnPath
        self.plantType = plantType
        self.moodType = MoodType.happy //Starts with a happy mood
        self.levelType = LevelType.baby //Starts as a baby
        self.isReadyToHarvest = false //Starts not ready to harvest
        self.moodSprite = SKSpriteNode.init() //Place holder
        
        let texture = SKTexture(imageNamed: "\(self.plantType)\(self.levelType.rawValue)")
        
        super.init(texture: texture, color: UIColor.clear, size: normalSize)
        
        //Adding face
        self.defineTextureOnLevelAndPlantType()
        self.moodSprite = SKSpriteNode(texture: SKTexture(imageNamed: "mood\(self.moodType.rawValue)"), size: CGSize(width: 100, height: 100))
        self.moodSprite.zPosition = 3
        self.moodSprite.position.x = 0
        self.moodSprite.position.y = 0
        self.addChild(moodSprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defineFoodNeeding() {
        self.foodNeeding = FoodType.randomFoodType()
    }
    
    /*Texture changing functions*/
    func defineTextureOnLevelAndPlantType(){
        let imageName = "\(self.plantType)\(self.levelType.rawValue)"
        self.texture = SKTexture(imageNamed: imageName)
        
        self.moodSprite.zPosition = 3
    }
    
    func defineMood(moodType: MoodType){
        self.moodType = moodType
        
        let imageName = "mood\(self.moodType.rawValue)"
        self.moodSprite.texture = SKTexture(imageNamed: imageName)
    }
    
    func levelUp(){
        self.levelType = LevelType.nextLevelTypeOf(levelType: self.levelType.rawValue)
        self.defineTextureOnLevelAndPlantType()
    }
    
    /* Behavior functions */
    func runIdleAction() {
        self.removeAllActions()
        
        let bouncingMovement = SKAction.sequence([SKAction.resize(toWidth: self.normalSize.width + 20, height: self.normalSize.height - 20, duration: 1),
                                                  SKAction.resize(toWidth: self.normalSize.width, height: self.normalSize.height, duration: 1)])
        
        self.run(SKAction.repeatForever(bouncingMovement))
    }
    
    func runDeath() {
        self.removeAllActions()
        
        let dieAnimation = SKAction.sequence([SKAction.run {
                                                self.defineMood(moodType: MoodType.sad)
                                                },
                                              SKAction.colorize(with: UIColor.darkGray, colorBlendFactor: 1, duration: 1),
                                              SKAction.resize(toWidth: self.normalSize.width + 20, height: self.normalSize.height - 40, duration: 1),
                                              SKAction.fadeOut(withDuration: 0.5)])
        self.run(dieAnimation)
    }
    
    func runEating() {
        self.removeAllActions()
        
        let eatAnimation = SKAction.sequence([SKAction.resize(toWidth: self.normalSize.width + 20, height: self.normalSize.height - 20, duration: 0.5),
                                     SKAction.resize(toWidth: self.normalSize.width, height: self.normalSize.height, duration: 0.3),
                                     SKAction.resize(toWidth: self.normalSize.width + 20, height: self.normalSize.height - 20, duration: 0.3),
                                     SKAction.resize(toWidth: self.normalSize.width, height: self.normalSize.height, duration: 0.3),
                                     SKAction.resize(toWidth: self.normalSize.width + 20, height: self.normalSize.height - 20, duration: 0.3),
                                     SKAction.run {
                                        self.runIdleAction()
            }])
        self.run(eatAnimation)
    }
}















