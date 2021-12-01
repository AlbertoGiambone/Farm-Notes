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
    
    //MARK: Action
    
    
    @IBAction func DoneButtonTapped(_ sender: UIBarButtonItem) {
        
        let db = Firestore.firestore()
        
        let todayDate = Date()
        let todayFormatter = DateFormatter()
        todayFormatter.dateStyle = .short
        let now = todayFormatter.string(from: todayDate)
        
        
        db.collection("notes").addDocument(data: [
            "title": String(noteTitle.text),
            "body": String(noteBody.text),
            "date": String(now),
            "UID": String(userID)
        ])
    }
    
    
    


}
