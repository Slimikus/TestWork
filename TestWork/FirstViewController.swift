//
//  FirstViewController.swift
//  TestWork
//
//  Created by Андрей Маковецкий on 27.06.17.
//  Copyright © 2017 Андрей Маковецкий. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftLocation
import CoreLocation
import MapKit

class FirstViewController: UIViewController  {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var weatherCity: UILabel!
    @IBOutlet weak var mapView: MKMapView!
     
    var city = ""
    var arraySingle: [String] = []
    
    func getData() {
        Location.getLocation(accuracy: .city, frequency: .oneShot, timeout: 80, cancelOnError: false, success: { _,location in
            self.arraySingle.append(String(describing: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)))
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            self.arraySingle.append(String(latitude))
            self.arraySingle.append(String(longitude))
            self.latitudeLabel.text = String(latitude)
            self.longitudeLabel.text = String(longitude)
            let loc = CLLocation(latitude: latitude, longitude: longitude)
            Location.getPlacemark(forLocation: loc, success: { placemark in
                if placemark.first!.addressDictionary!["City"] != nil {
                    self.city = String(describing: placemark.first!.addressDictionary!["City"]!)
                } else {
                    self.city = String(describing: placemark.first!.addressDictionary!["Name"]!)
                }
                self.cityLabel.text = self.city
                self.arraySingle.append(self.city)
                let appid = "69959b3831880164f37b3287b60db0aa"
                let url = "http://api.openweathermap.org/data/2.5/weather?"
                Alamofire.request(url, method: .get, parameters: ["q": self.city, "appid": appid]).validate()
                    .responseJSON { response in
                        switch response.result {
                        case .success(let value):
                            let json = JSON(value)
                            let tempCity = String(json["main"]["temp"].int! - 273) + "℃"
                            let weatherCity = json["weather"][0]["main"].string! + ", " + json["weather"][0]["description"].string!
                            self.TempLabel.text = tempCity
                            self.weatherCity.text = weatherCity
                            self.arraySingle.append(tempCity)
                            self.arraySingle.append(weatherCity)
                            arrayAll.append(self.arraySingle)
                            
                            let annotation = MKPointAnnotation()
                            annotation.title = tempCity
                            annotation.subtitle = weatherCity
                            annotation.coordinate.latitude = latitude
                            annotation.coordinate.longitude = longitude
                            self.mapView.showAnnotations([annotation], animated: true)
                            self.mapView.selectAnnotation(annotation, animated: true)
                            
                            UserDefaults.standard.set(arrayAll, forKey: "arrayAll")
                        case .failure(let error):
                            print(error)
                        }
                }
            }, failure: { error in
                print("Cannot retrive placemark due to an error \(error)")
            })
            
        }, error: { (_, last, error) in
            print("Something bad has occurred \(error)")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.value(forKey: "arrayAll") != nil {
            arrayAll = UserDefaults.standard.value(forKey: "arrayAll") as! [[String]]
        }
        
        do {
            getData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
