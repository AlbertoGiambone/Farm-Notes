//
//  AddSpaiyngViewController.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 28/01/22.
//

import UIKit
import Firebase

protocol AddContactDelegate{
    func AddContact(contact: Contact)
}

class AddSpaiyngViewController: UIViewController {

    
    var delegate: AddContactDelegate?
    
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
    
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        let todayDate = Date()
        let todayFormatter = DateFormatter()
        todayFormatter.dateStyle = .short
        let now = todayFormatter.string(from: todayDate)
        
        if edit == false {
            let SName: Contact = Contact(SPRAYERNAME: SprayerName.text ?? "")
            
            delegate?.AddContact(contact: SName)
            
        }else{
            
            let DOCREFERENCE = db.collection("FertilizationNote").document(ID!)
            
            
        }
        
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    
    

}
