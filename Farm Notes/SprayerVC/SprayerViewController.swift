//
//  SprayerViewController.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 29/12/21.
//

import UIKit
import Firebase
import Foundation

class SprayerViewController: UIViewController, UITextViewDelegate {

    
    //MARK: Connection
    
    @IBOutlet weak var sprayerTitle: UITextField!
    
    @IBOutlet weak var sprayerBody: UITextView!
    
    
    
    
    //MARK: LifeCycle
    
    var userID: String?
    
    var edit = false
    var ID: String?
    var noteBODY: String?
    var noteTITLE: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .systemIndigo

        userID = UserDefaults.standard.object(forKey: "userInfo") as? String
        
        if edit == false {
            sprayerBody.delegate = self
            sprayerBody.text = "Note..."
            sprayerBody.textColor = UIColor.lightGray
        }else{
            sprayerBody.delegate = self
            sprayerBody.text = noteBODY
            sprayerTitle.text = noteTITLE
            //noteBody.textColor = UIColor.lightGray
            
        }
    }


    //MARK: TEXVIEW placeholder being editing
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if sprayerBody.textColor == UIColor.lightGray {
            sprayerBody.text = ""
            sprayerBody.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

        if sprayerBody.text == "" {

            sprayerBody.text = "Note..."
            sprayerBody.textColor = UIColor.lightGray
        }
    }
    
    //MARK: Action
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        
        let db = Firestore.firestore()

        let day = Date()
        let dayFormatter = DateFormatter()
        dayFormatter.dateStyle = .short
        let now = dayFormatter.string(from: day)
        
        if edit == false {
            
            db.collection("SprayerNote").addDocument(data: ["type": String("SprayerNote"), "title": String(sprayerTitle.text!),
                "body": String(sprayerBody.text),
                "date": String(now),
                "UID": String(userID!)
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    //print("Document added with ID: \(ref.documentID)")
                    }
                }
        }else{
            let DOCREFERENCE = db.collection("SprayerNote").document(ID!)
            DOCREFERENCE.setData([
                "type": String("SprayerNote"),
                "title": String(sprayerTitle.text!),
                "body": String(sprayerBody.text),
                "date": String(now),
                "UID": String(userID!)
            ])
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
