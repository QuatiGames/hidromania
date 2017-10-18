//
//  TableViewEnhancementCell.swift
//  HidroMania
//
//  Created by Lucas Araujo on 18/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import Foundation



class TableViewEnhancementCell:GenericCell {
    
    override class var identifier:String {
        return "enhancementCell"
    }
    
    override class var nib:String {
        return "EnhancementCell"
    }
    
    override func configure(data: AnyObject) {
        if let ingredient = data as? IngredientData{
            self.textLabel?.text = "Enhancement \(ingredient.name)"
        }
    }
}
