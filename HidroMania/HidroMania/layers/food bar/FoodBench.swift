//
//  FoodTable.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit


class FoodBench:SKSpriteNode {
    
    var ingredients = Array<Ingredient>()
    var food:Food?
    
    func add(ingredient: Ingredient){
        self.ingredients.append(ingredient)
        
        //Change food on bench
        if ((self.food) != nil){
            self.food?.removeFromParent()
        }
        
        let atualFoodType = self.getFoodTypefromIngredients()
        self.food = Food(size: CGSize.init(width: 50, height: 50) , foodType: atualFoodType)
        self.food?.zPosition = 1
        self.food?.position = CGPoint(x: -self.size.width/2, y: self.size.height/2)
        
        self.addChild(self.food!)
    }
    
    func getFoodTypefromIngredients() -> FoodType{
        var atualString:String = String()
        
        for(ingredient) in self.ingredients{
            atualString.append(ingredient.data.type)
        }
        
        //Compare every kind of ingredient combination to get a Food Sprite
        //nitrogen
        if(atualString == "N"){
            return FoodType.N
        } else if (atualString == "NN") {
            return FoodType.NN
        } else if (atualString == "NNN") {
            return FoodType.NNN
        } else if (atualString == "Mg") {
            return FoodType.Mg
        } else if (atualString == "MgMg") {
            return FoodType.MgMg
        } else if (atualString == "MgMgMg") {
            return FoodType.MgMgMg
        } else if (atualString == "S") {
            return FoodType.S
        } else if (atualString == "SS") {
            return FoodType.SS
        } else if (atualString == "SSS") {
            return FoodType.SSS
        } else if (atualString == "K") {
            return FoodType.K
        } else if (atualString == "KK") {
            return FoodType.KK
        } else if (atualString == "KKK") {
            return FoodType.KKK
        } else if (atualString == "P") {
            return FoodType.P
        } else if (atualString == "PP") {
            return FoodType.PP
        } else if (atualString == "PPP") {
            return FoodType.PPP
        } else if (atualString == "KS" || atualString == "SK") {
            return FoodType.KS
        }else if (atualString == "KN" || atualString == "NK") {
            return FoodType.KN
        }else if (atualString == "KP" || atualString == "PK") {
            return FoodType.KP
        } else if (atualString == "MgS" || atualString == "SMg") {
            return FoodType.MgS
        }
        
        return FoodType(rawValue: 0)!
    }
}

