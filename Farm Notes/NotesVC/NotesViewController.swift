//
//  NotesViewController.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 24/11/21.
//

import UIKit
import Firebase

class NotesViewController: UIViewController, UITextViewDelegate {

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
        
        noteBody.delegate = self
        noteBody.text = "Note..."
        noteBody.textColor = UIColor.lightGray
        
    }
    
    //MARK: TEXVIEW placeholder being editing
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if noteBody.textColor == UIColor.lightGray {
            noteBody.text = ""
            noteBody.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

        if noteBody.text == "" {

            noteBody.text = "Note..."
            noteBody.textColor = UIColor.lightGray
        }
    }
    
    
    //MARK: Action
    
    
    @IBAction func DoneButtonTapped(_ sender: UIBarButtonItem) {
        
        let db = Firestore.firestore()
        
        let todayDate = Date()
        let todayFormatter = DateFormatter()
        todayFormatter.dateStyle = .short
        let now = todayFormatter.string(from: todayDate)
        
        
        db.collection("notes").addDocument(data: ["type": String("notes"), "title": String(noteTitle.text!),
            "body": String(noteBody.text),
            "date": String(now),
            "UID": String(userID!)
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                //print("Document added with ID: \(ref.documentID)")
                }
            }
    }
    
    
    


}
