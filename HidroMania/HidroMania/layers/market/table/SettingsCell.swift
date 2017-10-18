//
//  TableViewCellSettings.swift
//  HidroMania
//
//  Created by Lucas Araujo on 18/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import UIKit


class SettingsCell:GenericCell {
    
    override class var identifier:String {
        return "settingsCell"
    }
    
    override class var nib:String {
        return "SettingsCell"
    }
    
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var label: UILabel!
    
    override func configure(data: AnyObject) {
        if let str = data as? String{
            self.label.text = "\(str)"
        }
    }
}
