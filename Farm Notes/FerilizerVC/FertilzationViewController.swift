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
    
    
    var FirestoreArray = [String]()
    
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
                    FirestoreArray = ((documet.data()["distribution"] as? [String])!)
                    print("FERTITLEARRAY:    \(FirestoreArray)")
                        
                        var splitted = FirestoreArray.split(separator: ",")
                        print(splitted)
                }
                
            }
                
        }
    }
        self.table.reloadData()
}
    
    
    //DoneButton
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    //MARK: LyfeCycle
    
    var userID: String?
    
    var edit = false
    var ID: String?
    var fertTITLEARRAY = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("EDIT: \(edit)")
        self.navigationController?.navigationBar.tintColor = .systemPink
  
        table.delegate = self
        table.dataSource = self
        table.reloadData()
        
        table.layer.cornerRadius = 15
        table.backgroundColor = UIColor.systemGray5
        
        //MARK: toolbar
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([doneButton], animated: false)
        
        fertTitle.inputAccessoryView = toolBar
        fertNote.inputAccessoryView = toolBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        userID = UserDefaults.standard.object(forKey: "userInfo") as? String
        
        if edit == false {
        fertNote.delegate = self
        fertNote.text = "Note..."
        fertNote.textColor = UIColor.lightGray
        }else{
            fertNote.delegate = self
            
            
                self.fetchFirestore()
                
            
            run(after: 1){
                self.table.reloadData()
            }
            
                       
        }
        
        
    }
    
    //MARK: func for dispatch
    
    func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadLine = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadLine){
            completion()
        }
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
    
    //var FertArray = [FertModel]()
    var SaveFertArray = [String]()
    
    let db = Firestore.firestore()
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "New Fertilization", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Nitrogen"
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField.placeholder = "phosphorus"
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField.placeholder = "potassium"
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Kg/Ha"
            textField.keyboardType = .numberPad
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
            
            self.FirestoreArray.append(newFert)
            
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
        
        if edit == false {
        
        self.db.collection("FertilizationNote").addDocument(data: ["type": String("FertilizationNote"), "title": String(self.fertTitle.text ?? ""), "fertNotes": String(self.fertNote.text ?? ""), "fertDate": String(now), "distribution": FirestoreArray, "UID": String(self.userID!)
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                //print("Document added with ID: \(ref.documentID)")
                }
            }
        }else{
            
            let DOCREFERENCE = db.collection("FertilizationNote").document(ID!)
            
            DOCREFERENCE.setData([
                "type": String("FertilizationNote"),
                "title": String(self.fertTitle.text ?? ""),
                "fertNotes": String(self.fertNote.text ?? ""),
                "fertDate": String(now),
                "distribution": FirestoreArray,
                "UID": String(self.userID!)
            ])
            
            
            
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
    
    var totalN: Int = 0
    var totalP: Int = 0
    var totalK: Int = 0
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirestoreArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CELLFertilizerTableViewCell
        
        let FIRE = FirestoreArray[indexPath.row]
        
        let UUU = FIRE.components(separatedBy: " ")
        print("THIS IS FIRE: \(FIRE)")
        
        cell.Fdate.text = String("  \(UUU[0])")
        cell.Nlabel.text = String("\(UUU[1]) N")
        cell.Plabel.text = String("\(UUU[2]) P")
        cell.Klabel.text = String("\(UUU[3]) K")
        cell.KGlabel.text = String("\(UUU[4]) Kg/Ha")
        
        cell.backgroundColor = UIColor.systemGray5
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            FirestoreArray.remove(at: indexPath.row)
            
            
            let DOCREFERENCE = db.collection("FertilizationNote").document(ID!)
            
            DOCREFERENCE.updateData([
                "distribution": FirestoreArray
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            table.deleteRows(at: [indexPath], with: .fade)
            
            table.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRow = FirestoreArray[indexPath.row]
        
        let sep = selectedRow.components(separatedBy: " ")
        
        let alert = UIAlertController(title: "Edit Fertilization", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = sep[1]
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField.text = sep[2]
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField.text = sep[3]
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField.text = sep[4]
            textField.keyboardType = .numberPad
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
            
            self.FirestoreArray[indexPath.row] = newFert
            
            self.table.reloadData()
            }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
    }
    
}
    
    



