//
//  DetailViewController.swift
//  TestWork
//
//  Created by Андрей Маковецкий on 28.06.17.
//  Copyright © 2017 Андрей Маковецкий. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weathLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var arrayDetail: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = arrayDetail[0]
        cityLabel.text = arrayDetail[3]
        latLabel.text = arrayDetail[1]
        lonLabel.text = arrayDetail[2]
        tempLabel.text = arrayDetail[4]
        weathLabel.text = arrayDetail[5]
        
        let annotation = MKPointAnnotation()
        annotation.title = arrayDetail[4]
        annotation.subtitle = arrayDetail[5]
        annotation.coordinate.latitude = CLLocationDegrees(arrayDetail[1])!
        annotation.coordinate.longitude = CLLocationDegrees(arrayDetail[2])!
        self.mapView.showAnnotations([annotation], animated: true)
        self.mapView.selectAnnotation(annotation, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
