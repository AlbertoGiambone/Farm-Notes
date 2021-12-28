//
//  CELLFertilizerTableViewCell.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 28/12/21.
//

import UIKit

class CELLFertilizerTableViewCell: UITableViewCell {

    //MARK: Connection
    
    @IBOutlet weak var Fdate: UILabel!
    
    @IBOutlet weak var Nlabel: UILabel!
    
    @IBOutlet weak var Plabel: UILabel!
    
    @IBOutlet weak var Klabel: UILabel!
    
    @IBOutlet weak var KGlabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
