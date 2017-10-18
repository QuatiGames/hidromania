//
//  TableViewCellSettings.swift
//  HidroMania
//
//  Created by Lucas Araujo on 18/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import Foundation


class TableViewCellSettings:GenericCell {
    
    override class var identifier:String {
        return "settingsCell"
    }
    
    override class var nib:String {
        return "SettingsCell"
    }
    
    override func configure(data: AnyObject) {
        if let str = data as? String{
            self.textLabel?.text = "settings \(str)"
        }
    }
}
