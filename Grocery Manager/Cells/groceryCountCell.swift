//
//  groceryCountCell.swift
//  sip
//
//  Created by Sahil Kumar Bansal on 08/09/21.
//

import UIKit
import Foundation
class groceryCountCell: UITableViewCell {

    var tableHandler : ((_ count : UInt16)->Void)!
    @IBOutlet var tableGroceryNameLabel : UILabel!
    @IBOutlet var counter : UILabel!
    @IBOutlet var stack : UIStackView!
    var count = "0" {
        didSet{
            self.counter.text = count
        }
    }
    var totalCost = 0 {
        didSet{
            self.totalCostEachItem.text = "Rs " + String(totalCost)
        }
    }
    
    
    @IBOutlet var totalCostEachItem : UILabel!
    @IBAction func decrease()
    {
        guard var counts = UInt16(count) else {
            return
        }
        
        if counts > 0{
            counts -= 1
        }
        count =  String(counts)
        tableHandler(counts)
    }
    @IBAction func increase(){
        guard var counts = UInt16(count) else {
        return
        }
        counts += 1
        count =  String(counts)
//        counter.text = String(counts)
        tableHandler(counts)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
   
    
}
