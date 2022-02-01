//
//  AddSpaiyngViewController.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 28/01/22.
//

import UIKit
import Firebase



class AddSpaiyngViewController: UIViewController {

    
    //MARK: Connection
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var SprayerName: UITextField!
    
    @IBOutlet weak var quantity: UITextField!
    
    
    
    var edit = false
    var ID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        //Segment Color
        let titleTextAttributesForNormal = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let titleTextAttributesForSelected = [NSAttributedString.Key.foregroundColor: UIColor.systemIndigo]
        segment.setTitleTextAttributes(titleTextAttributesForNormal, for: .normal)
        segment.setTitleTextAttributes(titleTextAttributesForSelected, for: .selected)
        
        SprayerName.attributedPlaceholder = NSAttributedString(
            string: "Product Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray5])
    }
    
    
    
    //MARK: Action
    
    let db = Firestore.firestore()
    
    var spraying: String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        
        let todayDate = Date()
        let todayFormatter = DateFormatter()
        todayFormatter.dateStyle = .short
        let now = todayFormatter.string(from: todayDate)
        
        if edit == false {
            
            spraying = String("\(now) \(SprayerName.text!) \(quantity.text!)")
            
        }else{
            
            
        }
        
    }
   
    
    
    
    
    

}
