//
//  ProfileTableViewController.swift
//  iRepUSwift
//
//  Created by Jaime Moises Gutierrez on 3/22/16.
//  Copyright © 2016 MoiGtz. All rights reserved.
//

import UIKit
import MapKit

class ProfileTableViewController: UITableViewController, UIGestureRecognizerDelegate {

    var rep:Representative!
    
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var blurrView: UIView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var partyDetailLabel: UILabel!
    @IBOutlet var districtDetailLabel: UILabel!
    @IBOutlet var phoneDetailLabel: UILabel!
    @IBOutlet var officeDetailLabel: UILabel!
    @IBOutlet var linkDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapGesture(self.phoneDetailLabel, selector: "tappedPhone:")
        addTapGesture(self.linkDetailLabel, selector: "tappedLink:")
        addTapGesture(self.officeDetailLabel, selector: "tappedOffice:")
        
        self.title = "\(rep.name!)"
        self.stateLabel.text = "\(rep.state!)"
        self.partyDetailLabel.text = "\(rep.party!)"
        self.districtDetailLabel.text = "\(rep.district!)"
        self.phoneDetailLabel.text = "\(rep.phone!)"
        self.officeDetailLabel.text = "\(rep.office!)"
        self.linkDetailLabel.text = "\(rep.link!)"
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let address = "\(rep.office)"
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                
                let center = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                
                self.mapView.setRegion(region, animated: true)
                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))

            }
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tappedLink(sender:UITapGestureRecognizer){
        openURL(rep.link!)
    }
    
    func tappedPhone(sender:UITapGestureRecognizer){
        callNumber(rep.phone!)
    }
    
    func tappedOffice(sender:UITapGestureRecognizer){
        openAddress(rep.office!)
    }
    
    private func callNumber(var phoneNumber:String) {
        let stringArray = phoneNumber.componentsSeparatedByCharactersInSet(
            NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        phoneNumber = stringArray.joinWithSeparator("")
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            application.openURL(phoneCallURL)
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL)
            }
        }
    }
    
    private func openURL(url: String){
        if let checkURL = NSURL(string: url) {
            UIApplication.sharedApplication().openURL(checkURL)
        } else {
            print("invalid url")
        }
    }
    
    private func openAddress(var address: String){
        address = address.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        UIApplication.sharedApplication().openURL(NSURL(string: "http://maps.apple.com/?address=\(address)")!)
    }
    
    
    func addTapGesture(view: UIView, selector: Selector){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        view.addGestureRecognizer(tap)
        tap.delegate = self
    }
}
