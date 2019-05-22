//
//  ViewController.swift
//  capitals
//
//  Created by BJ on 2019-05-21.
//  Copyright © 2019 BJ. All rights reserved.
//

import WebKit
import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate, WKUIDelegate {

    @IBOutlet var mapView: MKMapView!
    var webView: WKWebView!
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        webView = WKWebView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Style", style: .plain, target: self, action: #selector(getMapOption))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.", url: URL(string: "https://en.wikipedia.org/wiki/London")!)
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", url: URL(string: "https://en.wikipedia.org/wiki/Oslo")!)
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", url: URL(string: "https://en.wikipedia.org/wiki/Paris")!)
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", url: URL(string: "https://en.wikipedia.org/wiki/Rome")!)
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", url: URL(string: "https://en.wikipedia.org/wiki/Washington,_D.C.")!)
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])

    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        guard annotation is Capital else { return nil }
        
        // 2
        let identifier = "Capital"
        
        // 3
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            // 4
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = UIColor.blue

            
            // 5
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // 6
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let capital = view.annotation as? Capital else { return }
//        let placeName = capital.title
//        let placeInfo = capital.info
        let placeUrl = capital.url
//
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
        
        let wvc = WebViewController()
        wvc.url = placeUrl
        navigationController?.pushViewController(wvc, animated: true)
    }
    
    @objc func getMapOption() {
        let ac = UIAlertController(title: "Which type?", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default) {
            [weak self] _ in
            self?.mapView.mapType = .hybrid
        })
        ac.addAction(UIAlertAction(title: "Satellite", style: .default) {
            [weak self] _ in
            self?.mapView.mapType = .satellite
        })
        ac.addAction(UIAlertAction(title: "Standard", style: .default) {
            [weak self] _ in
            self?.mapView.mapType = .standard
        })
        present(ac, animated: true)
    }
}
