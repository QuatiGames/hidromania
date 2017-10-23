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
    
    
    var ingredient:IngredientData?
    var enhancement:Enhancement?
    
    @IBOutlet weak var buyButtonOutlet: UIButton!
    
    @IBAction func buyButton(_ sender: Any) {
        if ingredient != nil {
            
            if player.money >= ingredient!.getPrice(){
                print("buying \(ingredient?.type ?? "" )...")
                player.money -= ingredient!.getPrice()
                player.change(ingredientType: ingredient!.type, value: 1)
            }
        }
        
        if enhancement != nil {
            if let enhancement = enhancement {
                if (player.enhancementsBought[enhancement.type] == false){
                    print("Buying \(enhancement.name)")
                    player.buyEnhancement(type: enhancement.type)
                    itemBougth()
                }
            }
        }
    }
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var ingredientImage: UIImageView!
    
    override func configure(data: AnyObject) {
        if let ingredient = data as? IngredientData{
            self.configureIngredient(ingredient)
        }
        
        if let enhancement = data as? Enhancement{
            self.configureEnhancement(enhancement)
        }
    }
    
    func configureIngredient(_ ingredient: IngredientData){
        self.ingredient = ingredient
        
        self.textLabel?.text = ingredient.name
        self.priceLabel.text = "$ \(ingredient.getPrice())"
        self.nameLabel.text = ingredient.name
        self.descriptionText.text = ingredient.description
        self.ingredientImage.image = UIImage(named: "\(ingredient.type)")
    }
    
    func configureEnhancement(_ enhancement: Enhancement){
        self.enhancement = enhancement
        
        self.textLabel?.text = enhancement.name
        self.priceLabel.text = "$ \(enhancement.price)"
        self.nameLabel.text = enhancement.name
        self.descriptionText.text = enhancement.description
        
        if (player.enhancementsBought[enhancement.type] == true){
            itemBougth()
        }
    }
    
    private func itemBougth(){
        buyButtonOutlet.backgroundColor = UIColor.gray
    }
    
    func configureCellView(){
        self.cellView.layer.cornerRadius = 5
        
        descriptionText.isScrollEnabled = false
        descriptionText.isEditable = false
        descriptionText.isUserInteractionEnabled = false
        
    }
    
}
