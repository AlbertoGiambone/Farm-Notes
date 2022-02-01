//
//  SprayerViewController.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 29/12/21.
//

import UIKit
import Firebase
import Foundation

class SprayerViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
  
    

    //MARK: Connection
    
    @IBOutlet weak var sprayerTitle: UITextField!
    
    @IBOutlet weak var sprayerBody: UITextView!
    
    @IBOutlet weak var table: UITableView!
    
        
    
    
    //MARK: LifeCycle
    
    var userID: String?
    
    var edit = false
    var ID: String?
    var noteBODY: String?
    var noteTITLE: String?
    var sprayingTime = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.dataSource = self
        table.delegate = self
        
        print("EDIT: \(edit)")
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
    
    let db = Firestore.firestore()
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        
        let db = Firestore.firestore()

        let day = Date()
        let dayFormatter = DateFormatter()
        dayFormatter.dateStyle = .short
        let now = dayFormatter.string(from: day)
        
        if edit == false {
            
            self.db.collection("SprayerNote").addDocument(data: ["type": String("SprayerNote"), "title": String(sprayerTitle.text ?? ""),
                "body": String(sprayerBody.text ?? ""),
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sprayingTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SprayerTableViewCell
        cell.HerbicideLabel.text = sprayingTime[indexPath.row]
        
        return cell
    }
    
    
    //MARK: Action
    
    @IBAction func addFertilizationTapped(_ sender: UIButton) {
        
        
        
        
        /*
        let alert = UIAlertController(title: "spraying", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Product Name"
            textField.keyboardType = .default
        }

        
        let action = UIAlertAction(title: "Save", style: .default)  { (_) in
            var N = alert.textFields![0].text
            var P = alert.textFields![1].text
            var K = alert.textFields![2].text
            var kg = alert.textFields![3].text
            
            let todayDate = Date()
            let todayFormatter = DateFormatter()
            todayFormatter.dateStyle = .short
            let now = todayFormatter.string(from: todayDate)
            
            if N == "" {
                N = "0"
            }
            if P == "" {
                P = "0"
            }
            if K == "" {
                K = "0"
            }
            if kg == "" {
                kg = "0"
            }
            
            
            let newFert = String("\(now) \(N!) \(P!) \(K!) \(kg!)")
            
            //self.FirestoreArray.append(newFert)
            
            //self.table.reloadData()
            }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
        
        
        */
        
    }
    
    @IBAction func unwindFromAddSpraying(_ sender: UIStoryboardSegue){
        
        if sender.source is AddSpaiyngViewController {
            
            if let senderVC = sender.source as? AddSpaiyngViewController {
                sprayingTime.append(senderVC.spraying!)
            }
            
            
        }
        table.reloadData()
    }
    
    
    
    
    
}
