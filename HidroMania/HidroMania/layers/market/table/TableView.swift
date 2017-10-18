//
//  FoodTab.swift
//  HidroMania
//
//  Created by Lucas Araujo on 18/10/17.
//  Copyright © 2017 QuatiGames. All rights reserved.
//

import SpriteKit
import UIKit


protocol CellConfigure {
    func configure(data:AnyObject)
}

class GenericCell:UITableViewCell, CellConfigure{
    func configure(data: AnyObject) { }
    class var identifier:String {
        return "cell"
    }
    
    class var nib:String {
        return "cell"
    }
}




class TableView<TCell:GenericCell>: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    var count:( () -> (Int))?
    var obj:((Int) -> (AnyObject))?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.clear
        self.separatorStyle = .none
        
        self.register(TCell.self, forCellReuseIdentifier: TCell.identifier)
        self.register(UINib(nibName: TCell.nib, bundle: nil), forCellReuseIdentifier: TCell.identifier)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let c = self.count {
            return c()
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TCell = tableView.dequeueReusableCell(withIdentifier: TCell.identifier)! as! TCell
        
        if let obj = obj{
            cell.configure(data: obj(indexPath.row) )
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil//"Section \(section)"
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}
