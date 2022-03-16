//
//  MapViewController.swift
//  Farm Notes
//
//  Created by Alberto Giambone on 01/03/22.
//

import UIKit
import MapboxMaps
import CoreLocation

class MapViewController: UIViewController {


    internal var map: MapView!
    @IBOutlet weak var mapView: MapView!
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .systemBlue
        
        let myResourceOptions = ResourceOptions(accessToken: "your_public_access_token")
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions)
        map = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         
        self.view.addSubview(map)
    }
    
    


}


