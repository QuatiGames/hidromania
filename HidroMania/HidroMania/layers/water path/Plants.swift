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
    var moodType:MoodType //Atual mood
    var moodSprite:SKSpriteNode //Sprite of the face
    var balloonSprite:Balloon? //Balloon of needing sprite
    var foodNeeding:FoodType? //Type of the food that the plant is needing
    var levelType: LevelType //Atual plant level
    let plantType: PlantType
    var isReadyToHarvest: Bool {
        didSet{
            self.foodNeeding = .unknown
            
            if (readyToHarvestEffect.parent == nil){
                self.addChild(readyToHarvestEffect)
            }
        }
    }
    var isDead:Bool = false
    var harvested:Bool = false
    var readyToHarvestEffect:SKEmitterNode
    
    var eatAnimation:SKAction?
    
    
    init(plantType: PlantType, positionOnPath: Int) {
        self.positionOnPath = positionOnPath
        self.plantType = plantType
        self.moodType = MoodType.happy //Starts with a happy mood
        self.levelType = LevelType.baby //Starts as a baby
        self.isReadyToHarvest = false //Starts not ready to harvest
        self.moodSprite = SKSpriteNode.init() //Place holder
        self.readyToHarvestEffect = SKEmitterNode(fileNamed: "ReadyHarvestParticle.sks")! //Adding ready to harvest effect
        
        
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
        
        starve = 4
        decreaseStarve()
        
        //Defining readyToHarvestEffect attributes
        self.readyToHarvestEffect.position = CGPoint(x: 0, y: 0)
        self.readyToHarvestEffect.zPosition = -1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defineFoodNeeding() {
        
        if isReadyToHarvest {
            return;
        }
        
        
        if balloonSprite == nil {
        
            
            self.foodNeeding = FoodType.randomFoodType()

            if let type = foodNeeding{
                //Automaticaly add a ballon when a new food need is setted
                
                self.addingBalloon(type: type)
            }
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
        self.removeAllActions()
        
        let bouncingMovement = SKAction.sequence([SKAction.resize(toWidth: self.normalSize.width + 20, height: self.normalSize.height - 20, duration: 1),
                                                  SKAction.resize(toWidth: self.normalSize.width, height: self.normalSize.height, duration: 1)])
        
        self.run(SKAction.repeatForever(bouncingMovement), withKey: "idle")
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
        
        self.run(dieAnimation) {
            self.isDead = true
        }
    }
    
    func runEating() {
        self.removeAllActions()
        
        eatAnimation = SKAction.sequence([SKAction.resize(toWidth: self.normalSize.width + 20, height: self.normalSize.height - 20, duration: 0.5),
                                     SKAction.resize(toWidth: self.normalSize.width, height: self.normalSize.height, duration: 0.3),
                                     SKAction.resize(toWidth: self.normalSize.width + 20, height: self.normalSize.height - 20, duration: 0.3),
                                     SKAction.resize(toWidth: self.normalSize.width, height: self.normalSize.height, duration: 0.3),
                                     SKAction.resize(toWidth: self.normalSize.width + 20, height: self.normalSize.height - 20, duration: 0.3),
                                     SKAction.run {
                                        self.runIdleAction()
            }])
        
        self.run(eatAnimation!, withKey: "eat")
        
        //Destroy balloon
        self.balloonSprite?.removeFromParent()
    }
    
    func checkIfIsInsight(food: Food) -> Bool {
        
        let diffx = abs(self.position.x - food.position.x)
        let diffy = abs(self.position.y - food.position.y)
        let diff = diffx + diffy
        
        return diff < 40
    }
    
    
    private var harverst = 0;
    private var growth:Int = 0 {
        didSet{
            if growth >= 1{
                levelUp()
                growth = 0
                
                harverst += 1
                
                if harverst >= 3 {
                    isReadyToHarvest = true
                    starveDisposer?.dispose()
                }
            }
        }
    }
    
    private var starveDisposer:Disposable?
    private var starveDuration:Double = 6
    private var maxStarve = 4
    private var dying = false
    
    private var starve:Int = 4 {
        didSet{
            if starve < 0 {
                self.dying = true
                self.runDeath()
                return
            }
            
            switch (starve){
            case 0:
                //print("Dying T_T")
                defineMood(moodType: .sad)
                break
            case 1:
                //print("Hungry :(")
                defineMood(moodType: .neutral)
                break
            case 2:
                //print("Hungry :|")
                defineMood(moodType: .neutral)
                break
            case 3:
                //print("Hungry :D")
                defineMood(moodType: .happy)
                defineFoodNeeding()
                break
            case 4:
                //print("Belly full")
                defineMood(moodType: .happy)
                break
            default:
                break
            }
        }
    }
    
    func eat(_ food:Food){
        
        
        if (dying == false){ // eat only if not dying
        
            self.runEating()
            
            balloonSprite?.removeFromParent()
            balloonSprite = nil
            
            starve = maxStarve;
            growth += 1
            
            starveDisposer?.dispose()
            decreaseStarve()
        }
    }
    
    func decreaseStarve(){
        
        if !isReadyToHarvest { // After harverst state Plant do not suffer anymore
            starveDisposer = async(delay: starveDuration) {
                self.starve -= 1
                self.decreaseStarve()
            }
        }
        
    }
}

