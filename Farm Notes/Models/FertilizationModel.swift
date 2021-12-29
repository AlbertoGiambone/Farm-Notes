//
//  FertilizationModel.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 28/12/21.
//

import Foundation


struct FertModel {
    
    var date: String
    var N: String
    var P: String
    var K: String
    var kg: String
    
    var dict: [String: Any] {
    return [
        
        "date": date,
        "N": N,
        "P": P,
        "K": K,
        "kg": kg
        
        ]
    }
    
    
}
