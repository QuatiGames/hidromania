//
//  MarketLayer.swift
//  HidroMania
//
//  Created by Lucas Araujo on 17/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit

class MarketLayer:Layer {
    
    fileprivate let midw = UIScreen.main.bounds.width*0.5
    fileprivate let midh = UIScreen.main.bounds.height*0.5
    
    fileprivate let w = UIScreen.main.bounds.width*0.5
    fileprivate let h = UIScreen.main.bounds.height*0.5
    
    
    var foodTab = SKSpriteNode(color: UIColor.yellow.withAlphaComponent(0.8), size: CGSize.zero)
    var enhancementTab = SKSpriteNode(color: UIColor.green.withAlphaComponent(0.8), size: CGSize.zero)
    var settingsTab = SKSpriteNode(color: UIColor.brown.withAlphaComponent(0.8), size: CGSize.zero)
    
    override init(size: CGSize) {
        super.init(size: size)
        self.addChild(foodTab)
        self.addChild(enhancementTab)
        self.addChild(settingsTab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var table:UITableView?
    var currentTab = "" {
        didSet{
            if (currentTab == "Comidas"){
                createFood()
            }else if (currentTab == "Melhorias"){
                createEnhancement()
            }else if (currentTab == "Ajustes"){
                createSettings()
            }else{
                // ...
            }
        }
    }
    
    
    override func didMove() {
        
        self.color = UIColor.lightGray
        
        
        foodTab.size =          CGSize(width: self.size.width/3, height: self.size.height*0.2)
        foodTab.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        
        enhancementTab.size =   CGSize(width: self.size.width/3, height: self.size.height*0.2)
        enhancementTab.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        
        settingsTab.size =      CGSize(width: self.size.width/3, height: self.size.height*0.2)
        settingsTab.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        
        foodTab.position.x = 0
        enhancementTab.position.x = foodTab.size.width
        settingsTab.position.x = foodTab.size.width + enhancementTab.size.width
        
        foodTab.position.y = size.height
        enhancementTab.position.y = size.height
        settingsTab.position.y = size.height
        
        
        currentTab = "Comidas"
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches {
            let location = t.location(in: self)
            
            for node in self.nodes(at: location){
                if node == foodTab{
                    currentTab = "Comidas"
                }
                
                if node == enhancementTab{
                    currentTab = "Melhorias"
                }
                
                if node == settingsTab{
                    currentTab = "Ajustes"
                }
            }
        }
        
    }
    
    
}



// Tabs
extension MarketLayer {
    
    func createSettings(){
        
        clearTable()
        
        table = TableView<SettingsCell>(frame: CGRect(x: midw - w/2, y: midh - h/2, width: w, height: h), style: .plain)
        table?.isScrollEnabled = false
        table?.allowsSelection = false
        
        if let table = table as? TableView<SettingsCell>{
            table.count = { return player.settings.count }
            table.obj = { index in return player.settings[index] as AnyObject }
            table.height = { return 60 }
            table.space = { return 0 }
            
            self.scene?.view?.addSubview(table)
            table.reloadData()
        }
        
    }
    
    func createFood(){
        
        clearTable()
        
        table = TableView<TableViewFoodCell>(frame: CGRect(x: midw - w/2, y: midh - h/2, width: w, height: h), style: .plain)
        table?.allowsSelection = false
        
        
        if let table = table as? TableView<TableViewFoodCell>{
            table.count = { return player.allIngredients.count }
            table.obj = { index in return player.allIngredients[index] as AnyObject }
            
            self.scene?.view?.addSubview(table)
            table.reloadData()
        }
    }
    
    func createEnhancement(){
        
        clearTable()
        
        table = TableView<TableViewFoodCell>(frame: CGRect(x: midw - w/2, y: midh - h/2, width: w, height: h), style: .plain)
        table?.allowsSelection = false
        
        if let table = table as? TableView<TableViewFoodCell>{
            table.count = { return player.allEnhancements.count }
            table.obj = { index in return player.allEnhancements[index] as AnyObject }
            
            self.scene?.view?.addSubview(table)
            table.reloadData()
        }
        
    }
    
    func clearTable(){
        if (table != nil){
            table!.removeFromSuperview()
            table!.frame = CGRect.zero
            table = nil
        }
    }
    
}
