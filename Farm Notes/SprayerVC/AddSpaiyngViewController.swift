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
    var editSpraying: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if edit == true {
            let UUU = editSpraying!.components(separatedBy: " ")
            
            SprayerName.text = String("\(UUU[1])")
            quantity.text = String("\(UUU[2])")
            if UUU[2] == "Gr/Ha" {
                segment.selectedSegmentIndex = 1
            }
            if UUU[2] == "Lt/Ha" {
                segment.selectedSegmentIndex = 0
            }
            
        }
        
        
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
            
            
            if segment.selectedSegmentIndex == 0 {
            
                spraying = String("\(now) \(SprayerName.text!) \(quantity.text!) Lt/Ha")
            }
            if segment.selectedSegmentIndex == 1 {
            
                spraying = String("\(now) \(SprayerName.text!) \(quantity.text!) Gr/Ha")
            }
            
        }else{
            
            
        }
        
    }
   
    
    
    
    
    

}
