//
//  FertilizationModel.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 28/12/21.
//

import Foundation


struct Sprayer {
    
    var type: String
    var title: String
    var sprayNotes: String
    var sprayDate: Date
    var distribution: String
    var UID: String
    var DID: String
    
    var dict: [String: Any] {
        return[
        
            "type": type,
            "title": title,
            "sprayNotes": sprayNotes,
            "sprayDate": sprayDate,
            "distribution": distribution,
            "UID": UID,
            "DID": DID
        
        ]
        
    }
    
    
}
