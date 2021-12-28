//
//  FertilzationViewController.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 30/11/21.
//

import UIKit
import Firebase
import Foundation

class FertilzationViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {

    
    //MARK: Connection
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var fertNote: UITextView!
    
    @IBOutlet weak var fertTitle: UITextField!
    
    
    
    func fetchFirestore() {
    let db = Firestore.firestore()
        db.collection("FertilizationNote").getDocuments() { [self](querySnapshot, err) in
            
            if let err = err {
                print("Error getting Firestore data: \(err)")
            }else{
                for documet in querySnapshot!.documents {
                
                    let y = documet.documentID
                    
                    if y == ID {
                    fertTitle.text = documet.data()["title"] as? String
                    fertNote.text = documet.data()["fertNotes"] as? String
                    fertTITLEARRAY = documet.data()["distribution"] as! [String]
                    print("FERTITLEARRAY:    \(fertTITLEARRAY)")
                }
                
            }
        }
    }
}
    
    //MARK: LyfeCycle
    
    var userID: String?
    
    var edit = false
    var ID: String?
    var fertTITLEARRAY = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .systemPink
        
        userID = UserDefaults.standard.object(forKey: "userInfo") as? String
        
        
        if edit == false {
        fertNote.delegate = self
        fertNote.text = "Note..."
        fertNote.textColor = UIColor.lightGray
        }else{
            fertNote.delegate = self
            
            fetchFirestore()
                        
                       
        }
        
        
        
        
        table.delegate = self
        table.dataSource = self
        
        
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if fertNote.textColor == UIColor.lightGray {
            fertNote.text = ""
            fertNote.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

        if fertNote.text == "" {

            fertNote.text = "Note..."
            fertNote.textColor = UIColor.lightGray
        }
    }
    
    
    //MARK: Action
    
    var FertArray = [String]()
    
    let db = Firestore.firestore()
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "New Fertilization", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Nitrogen"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "phosphorus"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "potassium"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Kg/Ha"
        }
        
        let action = UIAlertAction(title: "Save", style: .default)  { (_) in
            let N = alert.textFields![0].text
            let P = alert.textFields![1].text
            let K = alert.textFields![2].text
            let kg = alert.textFields![3].text
            
            let todayDate = Date()
            let todayFormatter = DateFormatter()
            todayFormatter.dateStyle = .short
            let now = todayFormatter.string(from: todayDate)
            
            let newFert = String("\(now) \(N!) \(P!) \(K!) \(kg!)")
            
            self.FertArray.append(newFert)
            
            self.table.reloadData()
            }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: DoneBUTTON tapped
    
    @IBAction func DoneButtonTapped(_ sender: UIBarButtonItem) {
        
        let todayDate = Date()
        let todayFormatter = DateFormatter()
        todayFormatter.dateStyle = .short
        let now = todayFormatter.string(from: todayDate)
        
        self.db.collection("FertilizationNote").addDocument(data: ["type": String("Fertilization"), "title": String(self.fertTitle.text ?? ""), "fertNotes": String(self.fertNote.text ?? ""), "fertDate": String(now), "distribution": FertArray, "UID": String(self.userID!)
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                //print("Document added with ID: \(ref.documentID)")
                }
            }
        
    
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: SPLIT ARRAY IN SINGLE WORDS OR VALUE SEPARATED BY WHATEVER
    
    
    func splitArray() {
    
    let myARRAY = "Joghy Ginger Gatti"
    let SplittedArray = myARRAY.components(separatedBy: " ")
    
    let BlackCat = SplittedArray[0]
    let RedCat = SplittedArray[1]
    let Animals = SplittedArray[2]
        
        print("\(BlackCat), \(RedCat), \(Animals)")
    }
    
    
    
    //MARK: Firestore Call
    
  //  func FirestoreCall() {
   //     db.collection("Fertilization").
  //  }
    
    
  
    //MARK: Tableview func
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FertArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CELLFertilizerTableViewCell
        
        let thisValue = FertArray[indexPath.row]
        let decpomponedArray = thisValue.components(separatedBy: " ")
        
        let date = decpomponedArray[0]
        let N = decpomponedArray[1]
        let P = decpomponedArray[2]
        let K = decpomponedArray[3]
        let kg = decpomponedArray[4]
        
        print("QUESTO E' N: \(N)")
        
        cell.Fdate.text = String(date)
        cell.Nlabel.text = String(N)
        cell.Plabel.text = String(P)
        cell.Klabel.text = String(K)
        cell.KGlabel.text = String("\(kg) Kg/Ha")
        
        return cell
    }
   
}
    
    



