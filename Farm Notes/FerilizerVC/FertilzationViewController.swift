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
        
        let action = UIAlertAction(title: "Add", style: .default)  { (_) in
            let N = alert.textFields![0].text
            let adress = alert.textFields![1].text
            let K = alert.textFields![2].text
            
            
            let db = Firebase.Firestore()
            
            db.collection("Fertilization").addDocument()
            
            
            
            self.table.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    
    
    
    

}
