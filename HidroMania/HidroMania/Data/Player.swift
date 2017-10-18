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
    private var ingredients = Dictionary<String,Int>()
    private var observers = Array<PlayerObserver>()
    
    
    
    init(){
        for i in 1...5 {
            ingredients["type\(i)"] = i*2
        }
    }
    
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
    private func updateObservers(){
        for obs in observers{
            obs.update()
        }
    }
    
}
