//
//  Player.swift
//  HidroMania
//
//  Created by Lucas Araujo on 18/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import Foundation

protocol PlayerObserver{
    func update()
    func leaveObservatory()
}

class Player {
    
    // Variables
    var money:UInt = 0 {
        didSet{
            updateObservers()
        }
    }
    var lifes:UInt = 0{
        didSet{
            updateObservers()
        }
    }
    fileprivate var ingredients = Dictionary<String,Int>()
    fileprivate var observers = Array<PlayerObserver>()
    
    
    
    init(){
        for i in 1...5 {
            ingredients["type\(i)"] = i*2
        }
    }
    
    
    
    
    let allIngredients:Array<IngredientData> = [
        IngredientData(n: "Potássio", t: "K", p: 100, d: "Elemento radioativo extremamente volátil"),
        IngredientData(n: "Magnésio", t: "Mg", p: 200, d: "Elemento radioativo extremamente volátil"),
        IngredientData(n: "Enxofre", t: "S", p: 300, d: "Elemento radioativo extremamente volátil"),
        IngredientData(n: "Fósforo", t: "P", p: 400, d: "Elemento radioativo extremamente volátil"),
        IngredientData(n: "Nitrogênio", t: "N", p: 500, d: "Elemento radioativo extremamente volátil")
        ]
    
    let settings:Array<String> = ["Music", "Effects"]
    
    
//    let allEnhancements = []
    
//    var enhancementsBought = []
    
}




// Observer
extension Player{
    // Add observer
    func addObserver(obs:PlayerObserver) -> Int{
        observers.append(obs)
        return observers.count - 1
    }
    
    // Destroy all observers
    func clearAllObservers(){
        for obs in observers{
            obs.leaveObservatory()
        }
        
        observers.removeAll()
    }
    
    
    // change value of specific ingredient
    func change(ingredientType:String, value:Int){
        if let v = ingredients[ingredientType] {
            
            if v + value < 0 {
                ingredients[ingredientType] = 0
            }else{
                ingredients[ingredientType] = v + value
            }
            
        }
        
        updateObservers()
    }
    
    // get value of specific ingredient
    func getValue(of ingredient:String) -> Int?{
        return ingredients[ingredient]
    }
    
    // remove a observer
    func removeObserver(at index:Int){
        observers.remove(at: index)
    }
    
    // update all observers
    fileprivate func updateObservers(){
        for obs in observers{
            obs.update()
        }
    }
}
