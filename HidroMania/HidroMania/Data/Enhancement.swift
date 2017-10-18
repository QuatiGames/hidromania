//
//  Enhancement.swift
//  HidroMania
//
//  Created by Lucas Araujo on 18/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import UIKit

struct Enhancement {
    var type:String
    var name:String
    var description:String
    var price:Int
    var image:UIImage
    
    init(n:String, t:String, d:String, p:Int){
        self.name = n
        self.type = t
        self.description = d
        self.price = p
        self.image = UIImage()
    }
    
}
