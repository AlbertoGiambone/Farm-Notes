//
//  CELLTableViewCell.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 22/11/21.
//

import UIKit

class CELLTableViewCell: RoundTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Connection
    
    @IBOutlet weak var titolo: UILabel!
    
    @IBOutlet weak var datelabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        
    }
    
}
