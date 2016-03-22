//
//  WhoIsMyRepAPI.swift
//  WhoIsMyRep
//
//  Created by Moises Gutierrez on 9/12/15.
//  Copyright (c) 2016 Moi Gutierrez. All rights reserved.
//

import UIKit
import Alamofire

class WhoIsMyRepApi: WhoIsMyRepApiProtocol {
    
    static let sharedInstance = WhoIsMyRepApi()
    
    var headers:[String:String] {
        get{
            return [
                "Content-Type": "application/xml"
            ]
        }
    }
    
    var APIManager = Alamofire.Manager.sharedInstance
    
    let baseURL = "http://whoismyrepresentative.com/"
    
    /*
    getall_mems.php
    
    DESCRIPTION: returns data on both representatives and senators by zipcode
    INPUT: zip, output (optional)
    RETURNS: name, state, district, phone, office, website
    EXAMPLE: http://whoismyrepresentative.com/getall_mems.php?zip=31023
    */
    
    func getAllMembers(zip: String, response: RequestResponse) {
        var getAllMembersUrl = "\(baseURL)/getall_mems.php?"
        getAllMembersUrl += "zip=\(zip)"
        APIManager.request(.GET, getAllMembersUrl).showHUD().checkConnectivity().debugLog().responseData(response)
    }
    
    /*
    getall_reps_byname.php
    
    DESCRIPTION: returns data on representatives by lastname
    INPUT: lastname, output (optional)
    RETURNS: name, state, district, phone, office, website
    EXAMPLE: http://whoismyrepresentative.com/getall_reps_byname.php?name=smith
    */
    
    func getAllRepresentativesByName(name: String, response: RequestResponse) {
        var getAllRepresentativesByNameURL = "\(baseURL)/getall_reps_byname.php?"
        getAllRepresentativesByNameURL += "name=\(name)"
        APIManager.request(.GET, getAllRepresentativesByNameURL).showHUD().checkConnectivity().debugLog().responseData(response)

    }
    
    /*
    getall_reps_bystate.php
    
    DESCRIPTION: returns data on representatives by state
    INPUT: state, output (optional)
    RETURNS: name, state, district, phone, office, website
    EXAMPLE: http://whoismyrepresentative.com/getall_reps_bystate.php?state=CA
    */
    
    func getAllRepresentativesByState(state: String, response: RequestResponse) {
        var getAllRepresentativesByStateURL = "\(baseURL)/getall_reps_bystate.php?"
        getAllRepresentativesByStateURL += "state=\(state)"
        APIManager.request(.GET, getAllRepresentativesByStateURL).showHUD().checkConnectivity().debugLog().responseData(response)
    }
    
    /*
    getall_sens_byname.php
    
    DESCRIPTION: returns data on senators by lastname
    INPUT: lastname, output (optional)
    RETURNS: name, state, district, phone, office, website
    EXAMPLE: http://whoismyrepresentative.com/getall_sens_byname.php?name=johnson
    */
    
    func getAllSenatorsByName(name: String, response: RequestResponse) {
        var getAllSenatorsByNameURL = "\(baseURL)/getall_sens_byname.php?"
        getAllSenatorsByNameURL += "name=\(name)"
        APIManager.request(.GET, getAllSenatorsByNameURL).showHUD().checkConnectivity().debugLog().responseData(response)
    }
    
    /*
    getall_sens_bystate.php
    
    DESCRIPTION: returns data on senators by state
    INPUT: state, output (optional)
    RETURNS: name, state, district, phone, office, website
    EXAMPLE: http://whoismyrepresentative.com/getall_sens_bystate.php?state=ME
    */
    
    func getAllSenatorsByState(state: String, response: RequestResponse) {
        var getAllSenatorsByStateURL = "\(baseURL)/getall_sens_bystate.php?"
        getAllSenatorsByStateURL += "state=\(state)"
        APIManager.request(.GET, getAllSenatorsByStateURL).showHUD().checkConnectivity().debugLog().responseData(response)
    }
}
