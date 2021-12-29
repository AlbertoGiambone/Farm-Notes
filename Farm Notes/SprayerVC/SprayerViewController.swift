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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .systemIndigo
        
        userID = UserDefaults.standard.object(forKey: "userInfo") as? String
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
}
