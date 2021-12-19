//
//  FertilzationViewController.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 30/11/21.
//

import UIKit
import Firebase

class FertilzationViewController: UIViewController, UITextViewDelegate {

    
    //MARK: Connection
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var fertNote: UITextView!
    
    @IBOutlet weak var fertTitle: UITextField!
    
    
    
    //MARK: LyfeCycle
    
    var userID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .systemPink
        
        userID = UserDefaults.standard.object(forKey: "userInfo") as? String
        
        fertNote.delegate = self
        fertNote.text = "Note..."
        fertNote.textColor = UIColor.lightGray
        
       // table.delegate = self
       // table.dataSource = self
        
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
    
    
    let db = Firestore.firestore()
    
    @IBAction func plusButtonTapped(_ sender: UIBarButtonItem) {
        
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
            textField.placeholder = "Kg"
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
            
            self.db.collection("Fertilization").addDocument(data: ["type": String("Fertilization"), "title": String(self.fertTitle.text ?? ""), "fertNotes": String(self.fertNote.text ?? ""), "N": String(N!), "P": String(P!), "K": String(K!), "kg": String(kg!), "fertDate": String(now), "UID": String(self.userID!)
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    //print("Document added with ID: \(ref.documentID)")
                    }
                }
            
            self.table.reloadData()
            }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: Firestore Call
    
  //  func FirestoreCall() {
   //     db.collection("Fertilization").
  //  }
    
    
  /*
    //MARK: Tableview func
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
   */
}
    
    



