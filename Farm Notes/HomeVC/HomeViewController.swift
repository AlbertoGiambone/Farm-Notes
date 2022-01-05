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
    

    
    
    //MARK: Firestore
    
    let db = Firestore.firestore()
    var NOTE = [HomeTV]()
    var sortedNOTE = [HomeTV]()
    var fertNote = [FertilizationNote]()
    
    func fetchFirestore() {
        
        db.collection("notes").getDocuments() { [self](querySnapshot, err) in
            
            if let err = err {
                print("Error getting Firestore data: \(err)")
            }else{
                for documet in querySnapshot!.documents {
                    
                    let y = documet.data()["UID"] as! String
                    
                    if y == userID {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    let d: Date = formatter.date(from: documet.data()["date"] as! String)!
                    
                        let u = HomeTV(type: documet.data()["type"] as? String ?? "", title: documet.data()["title"] as? String ?? "", body: documet.data()["body"] as? String ?? "", date: d, UID: documet.data()["UID"] as! String, DID: documet.documentID)
                        
                        self.NOTE.append(u)
                    }
                }
            
            }
        }
        
        db.collection("FertilizationNote").getDocuments() { [self](querySnapshot, err) in
            
            if let err = err {
                print("Error getting Firestore data: \(err)")
            }else{
                for documet in querySnapshot!.documents {
                
                    let y = documet.data()["UID"] as! String
                    
                    if y == userID {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    let d: Date = formatter.date(from: documet.data()["fertDate"] as! String)!
                    
                        let f = HomeTV(type: documet.data()["type"] as! String, title: documet.data()["title"] as? String ?? "", body: documet.data()["fertNotes"] as? String ?? "", date: d, UID: documet.data()["UID"] as! String, DID: documet.documentID)
                        
                        self.NOTE.append(f)
                    }
                    
                }
            }
        }
        
        db.collection("SprayerNote").getDocuments() { [self](querySnapshot, err) in
            
            if let err = err {
                print("Error getting Firestore data: \(err)")
            }else{
                for documet in querySnapshot!.documents {
                
                    let y = documet.data()["UID"] as! String
                    
                    if y == userID {
                        
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    let d: Date = formatter.date(from: documet.data()["date"] as! String)!
                    
                        let r = HomeTV(type: documet.data()["type"] as! String, title: documet.data()["title"] as? String ?? "", body: documet.data()["body"] as? String ?? "", date: d, UID: documet.data()["UID"] as! String, DID: documet.documentID)
                        
                        self.NOTE.append(r)
                    }
                
                }
            }
        }
        self.table.reloadData()
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
        
        self.fetchFirestore()
        run(after: 1){
            
            self.NOTE.sort(by:{$0.date > $1.date})
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
        
        
        run(after: 1){
            self.Listener()
            self.NOTE.sort(by:{$0.date > $1.date})
            self.table.reloadData()
        }
        
        
    
    }

    override func viewDidDisappear(_ animated: Bool) {
        NOTE.removeAll()
        sortedNOTE.removeAll()
        detach()
    }
    
    
    //MARK: LISTENER for Firestore
    
    func Listener() {
    
    db.collection("notes").addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    
                    let y = diff.document.data()["UID"] as! String
                    
                    if y == self.userID {
                        
                        let formatter = DateFormatter()
                        formatter.dateStyle = .short
                        let d: Date = formatter.date(from: diff.document.data()["date"] as! String)!
                        
                        let u = HomeTV(type: diff.document.data()["type"] as? String ?? "", title: diff.document.data()["title"] as? String ?? "", body: diff.document.data()["body"] as? String ?? "", date: d, UID: diff.document.data()["UID"] as! String, DID: diff.document.documentID)
                        
                        self.NOTE.append(u)
                        
                    }
                    
                }
                
            }
        }
        
        db.collection("FertilizationNote").addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        
                        let y = diff.document.data()["UID"] as! String
                        
                        if y == self.userID {
                        let formatter = DateFormatter()
                        formatter.dateStyle = .short
                            let d: Date = formatter.date(from: diff.document.data()["fertDate"] as! String)!
                        
                            let f = HomeTV(type: diff.document.data()["type"] as! String, title: diff.document.data()["title"] as? String ?? "", body: diff.document.data()["fertNotes"] as? String ?? "", date: d, UID: diff.document.data()["UID"] as! String, DID: diff.document.documentID)
                            
                            self.NOTE.append(f)
                        
                    }
                    
                }
            }
        
        }
    }
    
        //MARK: detach LISTENER
        
        func detach() {
        
        let listN = db.collection("notes").addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    print(diff.document.data())
                }
        
                let listF = self.db.collection("FertilizationNote").addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    print(diff.document.data())
                }
            
            listN.remove()
            listF.remove()
                    }
                }
            }
        }
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
        dayFormatter.dateStyle = .medium
        let stringDate = dayFormatter.string(from: day)
        
        let yyy = NOTE[indexPath.row].type
        
        switch yyy {
            
        case "notes":
            cell.titolo.text = String(NOTE[indexPath.row].title)
            cell.datelabel.text = String(stringDate)
            cell.bodyLabel.text = String(NOTE[indexPath.row].body)
            cell.typeImage.image = UIImage(named: "CustomIcon")
            
        case "FertilizationNote":
            cell.titolo.text = String(NOTE[indexPath.row].title)
            cell.datelabel.text = String(stringDate)
            cell.bodyLabel.text = String(NOTE[indexPath.row].body)
            cell.typeImage.image = UIImage(named: "FertilizerIcon")
            
        case "SprayerNote":
            cell.titolo.text = String(NOTE[indexPath.row].title)
            cell.datelabel.text = String(stringDate)
            cell.bodyLabel.text = String(NOTE[indexPath.row].body)
            cell.typeImage.image = UIImage(named: "SprayerIcon")
            
        default:
            print("no notes previously added...")
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    var docID: String?
    var nBODY: String?
    var nTITLE: String?
    var ifEDIT = false
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = NOTE[indexPath.row].type
        
        switch cell {
            
        case "notes":
            ifEDIT = true
            docID = NOTE[indexPath.row].DID
            nBODY = NOTE[indexPath.row].body
            nTITLE = NOTE[indexPath.row].title
            performSegue(withIdentifier: "notes", sender: nil)
            
        case "FertilizationNote":
            ifEDIT = true
            docID = NOTE[indexPath.row].DID
            performSegue(withIdentifier: "fertilizer", sender: nil)
            
        case "SprayerNote":
            ifEDIT = true
            docID = NOTE[indexPath.row].DID
            nBODY = NOTE[indexPath.row].body
            nTITLE = NOTE[indexPath.row].title
            performSegue(withIdentifier: "sprayer", sender: nil)
            
        default:
            print("no cell selected...;)")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let type = NOTE[indexPath.row].type
            let doc = NOTE[indexPath.row].DID
            
            db.collection(type).document(doc).delete()
            NOTE.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .fade)
            
            table.reloadData()
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "notes" {
            let secondVC = segue.destination as! NotesViewController
            secondVC.edit = ifEDIT
            secondVC.ID = docID
            secondVC.noteBODY = nBODY
            secondVC.noteTITLE = nTITLE
        }
        if segue.identifier == "fertilizer" {
            let secondVC = segue.destination as! FertilzationViewController
            secondVC.edit = ifEDIT
            secondVC.ID = docID
        }
        if segue.identifier == "sprayer" {
            let secondVC = segue.destination as! SprayerViewController
            secondVC.edit = ifEDIT
            secondVC.ID = docID
            secondVC.noteBODY = nBODY
            secondVC.noteTITLE = nTITLE
        }
    }
    
    
    //MARK: Action
    
    
    
    

}



