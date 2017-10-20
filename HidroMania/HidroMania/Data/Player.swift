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
    var money:Double = 0 {
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
    
    var discount = 1.0
    
    
    init(){
        for ing in allIngredients {
            ingredients[ing.type] = 10
        }
    }
    
    
    let allIngredients:Array<IngredientData> = [
        IngredientData(n: "Potássio", t: "K", p: 10, d: "Elemento radioativo extremamente volátil"),
        IngredientData(n: "Magnésio", t: "Mg", p: 20, d: "Elemento radioativo extremamente volátil"),
        IngredientData(n: "Enxofre", t: "S", p: 20, d: "Elemento radioativo extremamente volátil"),
        IngredientData(n: "Fósforo", t: "P", p: 20, d: "Elemento radioativo extremamente volátil"),
        IngredientData(n: "Nitrogênio", t: "N", p: 10, d: "Elemento radioativo extremamente volátil")
        ]
    
    let settings:Array<String> = ["Music", "Effects"]
    
    
    let allEnhancements:Array<Enhancement> = [
        Enhancement(n: "Abertura para o sol",t: "enh1", d: "A Abertura para o sol é muito saudável para as plantas", p: 5000),
        Enhancement(n: "Bomba mais forte",t: "enh2", d: "Aumento da velocidade da bomba em 20%", p: 7000),
        Enhancement(n: "Descontos em nutrientes",t: "enh3", d: "Nutrientes são 20% mais baratos", p: 10000),
        Enhancement(n: "Abertura para o sol",t: "enh4", d: "A Abertura para o sol é muito saudável para as plantas", p: 12000),
                                              ]
    
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





//Util

protocol Disposable {
    func dispose()
}

fileprivate class Disposer:NSObject, Disposable{
    
    var isDisposed = false
    
    func dispose(){
        isDisposed = true
    }
}

//Global Funcs
func async(delay:Double = 0,_ block: @escaping () -> () ) -> Disposable{
    
    if(delay < 0){
        block()
    }
    
    let disp = Disposer()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay , execute: {() in
        if disp.isDisposed == false{
            block()
        }
    })
    
    return disp
}

//Double Extension

public extension UInt32 {
    func random() -> UInt32 {
        return arc4random() % self
    }
    
    func random(_ low:UInt32) -> UInt32 {
        return arc4random() % (self - low) + low
    }
}
