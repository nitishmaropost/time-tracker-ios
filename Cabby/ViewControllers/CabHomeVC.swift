//
//  CabHomeVC.swift
//  Timely
//
//  Created by Maropost India on 19/09/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class CabHomeVC: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var viewTaxi: UIView!
    @IBOutlet weak var constraint_height_viewTaxi: NSLayoutConstraint!
    
    // Variables
    var camera: GMSCameraPosition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    func configureUI() {
//        guard let mapStyle = Bundle.main.url(forResource: "map-style", withExtension: "json") else {
//            return
//        }
//
//        do {
//            self.mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: mapStyle)
//        } catch {
//            print("json not found")
//        }
        
        DispatchQueue.main.async {
            self.camera = GMSCameraPosition.camera(withLatitude: 30.67995, longitude: 76.72211, zoom: 17.0)
            self.mapView.animate(to: self.camera)
            self.mapView.isMyLocationEnabled = true
            self.mapView.settings.compassButton = true
            let tapGestureMap = UIPanGestureRecognizer(target: self, action: #selector(self.didDragMap(_:)))
            tapGestureMap.delegate = self
            self.mapView.addGestureRecognizer(tapGestureMap)
            
            let userLocationMarker = GMSMarker(position: CLLocationCoordinate2DMake(30.67995, 76.72211))
            userLocationMarker.icon = UIImage(named: "pin_map.png")
            userLocationMarker.map = self.mapView
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.view.backgroundColor = UIColor.clear
        }
    }
    
    @objc func didDragMap(_ sender: UIGestureRecognizer) {
        if sender.state == .began {
            
            // do something here
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            UIView.animate(withDuration: 1) {
                self.constraint_height_viewTaxi.constant = 0
            }
        } else if sender.state == .ended {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            UIView.animate(withDuration: 1) {
                self.constraint_height_viewTaxi.constant = 200
            }
        }
    }
}

extension CabHomeVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        //  Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        filter.country = "IN"
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
        return false
    }
}

extension CabHomeVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place ID: \(place.placeID)")
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        self.camera = GMSCameraPosition.camera(withLatitude: 30.67995, longitude: 76.72211, zoom: 17.0)
        self.mapView.animate(to: self.camera)
        return true
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

extension CabHomeVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}
