//
//  NotesViewController.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 24/11/21.
//

import UIKit
import Firebase

class NotesViewController: UIViewController {

    
    
    
    //MARK: Connection
    
    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var noteBody: UITextView!
    
    
    //MARK: FireStore
    
   
    
    //MARK: Lifecycle
    
    var userID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .systemGreen
        
        userID = UserDefaults.standard.object(forKey: "userInfo") as? String
    }
    
    
    
    
    


}
