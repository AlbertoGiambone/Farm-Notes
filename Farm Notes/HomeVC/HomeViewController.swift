//
//  HomeViewController.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 22/11/21.
//

import UIKit
import Firebase
import FirebaseUI

class HomeViewController: UIViewController, FUIAuthDelegate, UITableViewDelegate, UITableViewDataSource {

    //MARK: Connection
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var custom: RoundButton!
    
    @IBOutlet weak var fertilization: RoundButton!
    
    @IBOutlet weak var spraying: RoundButton!
    
    @IBOutlet weak var maintenance: RoundButton!
    
    @IBOutlet weak var thingsToBuy: RoundButton!
    
    
    //MARK: Firestore
    
    let db = Firestore.firestore()
    var NOTE = [notes]()
    
    func fetchFirestore() {
        
        db.collection("notes").getDocuments() { [self](querySnapshot, err) in
            
            if let err = err {
                print("Error getting Firestore data: \(err)")
            }else{
                for documet in querySnapshot!.documents {
                    
                    let y = documet.data()["UID"] as! String
                    
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    let d: Date = formatter.date(from: documet.data()["date"] as! String)!
                    
                    if y == userID {
                        let u = notes(type: documet.data()["type"] as! String, title: documet.data()["title"] as! String, body: documet.data()["body"] as! String, date: d, UID: documet.data()["UID"] as! String, DID: documet.documentID)
                        
                        self.NOTE.append(u)
                        print(u)
                    }
                }
                self.NOTE.sorted(by: {$1.date < $0.date})
                self.table.reloadData()
                print("\(NOTE) QUESTE SONO LE NOTE!")
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
    
    
    //Mark: LifeCycle
    
    var userID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        table.delegate = self
        table.dataSource = self

        run(after: 1){
            self.fetchFirestore()
        }
        run(after: 2){
            self.table.reloadData()
        }
    
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        //MARK: Sign IN
        
        if UserDefaults.standard.object(forKey: "userInfo") == nil {
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else { return }
            let isAnonymous = user.isAnonymous  // true
            UserDefaults.standard.setValue(user.uid, forKey: "userInfo")
            if isAnonymous == true {
                print("User is signed in with UID \(user.uid)")
                }
            }
        }else{
            print("USER ALREADY LOGGED IN!!!")
            
        }
        
        userID = UserDefaults.standard.object(forKey: "userInfo") as? String
        
        
    
    }
    //Mark: tableview func
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NOTE.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CELLTableViewCell
        
        let day = NOTE[indexPath.row].date
        let dayFormatter = DateFormatter()
        dayFormatter.dateStyle = .short
        let stringDate = dayFormatter.string(from: day)
        
        cell.titolo.text = String(NOTE[indexPath.row].title)
        cell.datelabel.text = String(stringDate)
        cell.bodyLabel.text = String(NOTE[indexPath.row].body)
        
        
        
        return cell
    }
    
     
    
    
    
    /*
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    */
    

}


