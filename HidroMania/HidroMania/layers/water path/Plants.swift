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
    
    //Find maxium enum value
    private static let _max: PlantType.RawValue = {
        var maxValue: Int = 0
        while let _ = PlantType(rawValue: maxValue){
            maxValue += 1
        }
        
        return maxValue - 1
    }()
    
    //return a random PlantType value
    static func randomPlantType() -> PlantType {
        //Pick and return a new value from 1 to _max
        let rand = arc4random_uniform(UInt32(_max - 1)) + 1
        
        return PlantType(rawValue: Int(rand))!
    }
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
    var balloonSprite:Balloon?
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
        self.zPosition = 2
        
        self.addChild(moodSprite)
        
        starve = 3
        decreaseStarve()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defineFoodNeeding() {
        defineMood(moodType: MoodType.neutral)
        self.foodNeeding = FoodType.randomFoodType()
        if let type = foodNeeding{
            //Automaticaly add a ballon when a new food need is setted
            self.addingBalloon(type: type)
        }
    }
    
    func addingBalloon(type:FoodType) {
        self.balloonSprite = Balloon(foodType: type)
        self.balloonSprite?.position.x = self.size.width/4
        self.balloonSprite?.position.y = self.size.height/4
        self.balloonSprite?.zPosition = 3
        
        self.addChild(self.balloonSprite!)
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
        self.defineMood(moodType: MoodType.happy)
        self.removeAllActions()
        
        let bouncingMovement = SKAction.sequence([SKAction.resize(toWidth: self.normalSize.width + 20, height: self.normalSize.height - 20, duration: 1),
                                                  SKAction.resize(toWidth: self.normalSize.width, height: self.normalSize.height, duration: 1)])
        
        self.run(SKAction.repeatForever(bouncingMovement))
    }
    
    func runDeath() {
        self.defineMood(moodType: MoodType.sad)
        self.removeAllActions()
        
        let dieAnimation = SKAction.sequence([SKAction.run {
                                                self.defineMood(moodType: MoodType.sad)
                                                },
                                              SKAction.colorize(with: UIColor.darkGray, colorBlendFactor: 1, duration: 1),
                                              SKAction.resize(toWidth: self.normalSize.width + 20, height: self.normalSize.height - 40, duration: 1),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.run {
                                                self.removeFromParent()
            }])
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
        
        //Destroy balloon
        self.balloonSprite?.removeFromParent()
    }
    
    func checkIfIsInsight(food: Food) -> Bool {
        
        let diffx = abs(self.position.x - food.position.x)
        let diffy = abs(self.position.y - food.position.y)
        let diff = diffx + diffy
        
        return diff < 40
    }
    
    
    
    
    
    
    var growth:Int = 0 {
        didSet{
            if growth >= 3{
                levelUp()
                starve = 3
                growth = 0
            }
        }
    }
    var starveDisposer:Disposable?
    var starveDuration:Double = 5
    var starve:Int = 0 {
        didSet{
            if starve < 0 {
                self.runDeath()
                return
            }
            
            switch (starve){
            case 0:
                defineMood(moodType: .sad)
                break
            case 1:
                defineMood(moodType: .neutral)
                break
            case 2:
                defineMood(moodType: .neutral)
                break
            case 3:
                defineMood(moodType: .happy)
                break
            default:
                break
            }
        }
    }
    
    func eat(_ food:Food){
        self.runEating()
        starve = 3;
        growth += 1
        starveDisposer?.dispose()
        decreaseStarve()
    }
    
    func decreaseStarve(){
        
        starveDisposer = async(delay: starveDuration) {
            self.starve -= 1
            self.decreaseStarve()
        }
        
    }
}















