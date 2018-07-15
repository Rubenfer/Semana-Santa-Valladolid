//
//  MapaViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapaViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    let iglesias = ["Iglesia Vera Cruz", "Iglesia San Pablo", "Monasterio de San Benito el Real", "Iglesia de Santa María La Antigua","Convento de Porta Coeli","Iglesia de San Miguel","Iglesia de Nuestro Padre Jesús Nazareno","Iglesia de San Pedro Apóstol","Catedral de Valladolid"]
    let latitudes = [41.6537681,41.6569093,41.654211,41.653947,41.6504,41.655028,41.652679,41.657514,41.652678]
    let longitudes = [-4.7264494,-4.7247811,-4.729367,-4.722927,-4.72605,-4.727133,-4.72922,-4.718089,-4.723415]
    
    @IBOutlet var mapView: MKMapView!
    var locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: 41.6519657, longitude: -4.7284892)
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        requestLocationAccess()
        locationManager.startUpdatingLocation()
        centerMapOnLocation(location: initialLocation)
        mapView.showsUserLocation = true
        for i in iglesias.indices {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitudes[i], longitude: longitudes[i])
            annotation.title = iglesias[i]
            mapView.addAnnotation(annotation)
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius*2.0, regionRadius*2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
        case .denied, .restricted:
            print("location access denied")
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
}
