//
//  MapVC.swift
//  DutyPharmacy
//
//  Created by Berire Şen Ayvaz on 17.01.2023.
//

import UIKit
import MapKit

class MapVC: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    var datum = Datum()
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    var annotationTitle = ""
    var annotationSubtitle = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        zoomLocation()
        
    }
    
    
    //MARK: LocationManager Kurulum, Yol tarifi ve zoom işlemleri
    func setupLocationManager(){
        self.mapView.showsUserLocation = true
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let requestLocation = CLLocation(latitude: datum.latitude ?? 0.0, longitude: datum.longitude ?? 0.0)
        CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
            if let placemark = placemarks {
                if placemark.count > 0 {
                    let newPlacemark = MKPlacemark(placemark: placemark[0])
                    let item = MKMapItem(placemark: newPlacemark)
                    item.name = self.annotationTitle
                    let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                    item.openInMaps(launchOptions:launchOptions)
                }
            }
        }
    }
    func zoomLocation(){
        createAnnonations(locations: [["title":  datum.eczaneAdi ?? "", "latitude" :  datum.latitude ?? 0.0,"longitude" :datum.longitude ?? 0.0]])
        let gelenLoc = CLLocationCoordinate2D(latitude:  datum.latitude ?? 0.0, longitude: datum.longitude ?? 0.0)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: gelenLoc, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    //MARK: Pin oluşturma  ve pin özelleştirme işlemleri
    func createAnnonations(locations: [[String: Any]]){
        
        for location in locations{
            let annotations  = MKPointAnnotation()
            annotations.title = location["title"] as? String
            if   datum.yolTarifi  != "" {
                annotations.subtitle = datum.yolTarifi
            }else {
                annotations.subtitle = ""
                
            }
            annotations.coordinate = CLLocationCoordinate2D(latitude: datum.latitude ?? 0.0, longitude: datum.longitude ?? 0.0)
            mapView.addAnnotation(annotations)
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.tintColor = UIColor.red
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
            
        }else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
}
//MARK: Kullanıcı konumu update
extension ViewController {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: locValue.latitude, longitude:  locValue.longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in
            
            placemarks?.forEach { (placemark) in
                
                if let city = placemark.administrativeArea {
                    self.viewModel.getDutyPharmacy(city: city.forSorting)
                }
            }
        })
    }
}
