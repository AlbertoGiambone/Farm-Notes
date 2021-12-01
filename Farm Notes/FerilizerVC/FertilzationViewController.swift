//
//  FertilzationViewController.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 30/11/21.
//

import UIKit
import Firebase

class FertilzationViewController: UIViewController {

    
    //MARK: Connection
    
    @IBOutlet weak var table: UITableView!
    
    
    
    //MARK: LyfeCycle
    
    var userID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .systemPink
        
        userID = UserDefaults.standard.object(forKey: "userInfo") as? String
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
        
        let action = UIAlertAction(title: "Add", style: .default)  { (_) in
            let N = alert.textFields![0].text
            let P = alert.textFields![1].text
            let K = alert.textFields![2].text
            let kg = alert.textFields![3].text
            
            let todayDate = Date()
            let todayFormatter = DateFormatter()
            todayFormatter.dateStyle = .short
            let now = todayFormatter.string(from: todayDate)
            
            self.db.collection("Fertilization").addDocument(data: ["type": String("Fertilization"), "N": String(N!), "P": String(P!), "K": String(K!), "kg": String(kg!), "fertDate": String(now), "UID": String(self.userID!)
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

}
    
    



