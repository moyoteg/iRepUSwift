//
//  WhoIsMyRepApiManager.swift
//  WhoIsMyRep
//
//  Created by Moi Gutierrez on 9/14/15.
//  Copyright (c) 2016 Moi Gutierrez. All rights reserved.
//

import UIKit
import Alamofire

class WhoIsMyRepApiManager: NSObject {
    static let API = WhoIsMyRepApi()
}

typealias RequestResponse = (response: Response<NSData, NSError>) -> Void

protocol WhoIsMyRepApiProtocol {
  
    /*
    getall_mems.php
    
    DESCRIPTION: returns data on both representatives and senators by zipcode
    INPUT: zip, output (optional)
    RETURNS: name, state, district, phone, office, website
    EXAMPLE: http://whoismyrepresentative.com/getall_mems.php?zip=31023
    */
    
    func getAllMembers(zip: String, response: RequestResponse)
    
    /*
    getall_reps_byname.php
    
    DESCRIPTION: returns data on representatives by lastname
    INPUT: lastname, output (optional)
    RETURNS: name, state, district, phone, office, website
    EXAMPLE: http://whoismyrepresentative.com/getall_reps_byname.php?name=smith
    */
    
    func getAllRepresentativesByName(name: String, response: RequestResponse)
    
    /*
    getall_reps_bystate.php
    
    DESCRIPTION: returns data on representatives by state
    INPUT: state, output (optional)
    RETURNS: name, state, district, phone, office, website
    EXAMPLE: http://whoismyrepresentative.com/getall_reps_bystate.php?state=CA
    */
    
    func getAllRepresentativesByState(state: String, response: RequestResponse)
    
    /*
    getall_sens_byname.php
    
    DESCRIPTION: returns data on senators by lastname
    INPUT: lastname, output (optional)
    RETURNS: name, state, district, phone, office, website
    EXAMPLE: http://whoismyrepresentative.com/getall_sens_byname.php?name=johnson
    */
    
    func getAllSenatorsByName(name: String, response: RequestResponse)
    
    /*
    getall_sens_bystate.php
    
    DESCRIPTION: returns data on senators by state
    INPUT: state, output (optional)
    RETURNS: name, state, district, phone, office, website
    EXAMPLE: http://whoismyrepresentative.com/getall_sens_bystate.php?state=ME
    */
    
    func getAllSenatorsByState(state: String, response: RequestResponse)
    
}

class NetworkResponse {
    
    var error:NSError?
    var statusCode:Int
    var errorMessage:String?
    var response:NSHTTPURLResponse?
    
    init(statusCode:Int, error:NSError? = nil, errorMessage:String? = nil, response:NSHTTPURLResponse? = nil) {
        self.statusCode = statusCode
        self.error = error
        self.errorMessage = errorMessage
        self.response = response
    }
}