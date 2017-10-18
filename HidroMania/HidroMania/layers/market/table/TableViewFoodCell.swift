//
//  TableViewFoodCell.swift
//  HidroMania
//
//  Created by Lucas Araujo on 18/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import UIKit

class TableViewFoodCell: GenericCell {
    
    override class var identifier:String {
        return "foodCell"
    }
    
    override class var nib:String {
        return "FoodCell"
    }
    
    override func configure(data: AnyObject) {
        if let ingredient = data as? IngredientData{
            
            self.textLabel?.text = ingredient.name
            
        }
    }
    
}
