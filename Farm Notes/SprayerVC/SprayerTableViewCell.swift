//
//  SprayerTableViewCell.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 24/01/22.
//

import UIKit

class SprayerTableViewCell: UITableViewCell {

    
    //MARK: Connection
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var HerbicideLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
