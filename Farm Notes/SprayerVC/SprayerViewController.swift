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
        
        table.delegate = self
        table.dataSource = self
        table.reloadData()
        
        table.layer.cornerRadius = 15
        table.backgroundColor = UIColor.systemGray5
        
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
                "distribution": sprayingTime,
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
                "distribution": sprayingTime,
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
        
        let FIRE = sprayingTime[indexPath.row]
        
        let UUU = FIRE.components(separatedBy: " ")
        print("THIS IS FIRE: \(FIRE)")
        
        cell.dateLabel.text = String("  \(UUU[0])")
        cell.HerbicideLabel.text = String("\(UUU[1])")
        cell.quantityLabel.text = String("\(UUU[2]) \(UUU[3])")
        
        cell.backgroundColor = UIColor.systemGray5
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    var selected: String?
    var IND: Int?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = sprayingTime[indexPath.row]
        IND = sprayingTime.firstIndex(of: selected!)!
        performSegue(withIdentifier: "editTV", sender: nil)
    }
    
    //MARK: Action
    
  
    
    @IBAction func unwindFromAddSpraying(_ sender: UIStoryboardSegue){
        
        if sender.source is AddSpaiyngViewController {
            
            if let senderVC = sender.source as? AddSpaiyngViewController {
                
                if senderVC.edit == true {
                    sprayingTime[senderVC.IOABACK!] = senderVC.spraying!
                }else{
                sprayingTime.append(senderVC.spraying!)
                }
            }
            
        }
        table.reloadData()
    }
    
    //MARK: segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTV" {
            let nextVC = segue.destination as? AddSpaiyngViewController
            nextVC?.editSpraying = selected
            nextVC?.edit = true
            nextVC?.IOA = IND
        }
    }
    
    
    
}
