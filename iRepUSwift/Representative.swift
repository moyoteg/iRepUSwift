//
//  Representative.swift
//  iRepUSwift
//
//  Created by Jaime Moises Gutierrez on 3/16/16.
//  Copyright © 2016 MoiGtz. All rights reserved.
//

import Foundation
import SWXMLHash

struct Representative {
    
    /*
    <rep name="Austin Scott" party="R" state="GA" district="8" phone="202-225-6531" office="2417 Rayburn House Office Building" link="http://austinscott.house.gov" />
    */
    
    var name:String?
    var party:String?
    var state:String?
    var district:String?
    var phone:String?
    var office:String?
    var link:String?
    
    init(name: String? = "", party: String? = "", state: String? = "", district: String? = "", phone: String? = "", office: String? = "", link: String? = "") {
        self.name = name
        self.party = party
        self.state = state
        self.district = district
        self.phone = phone
        self.office = office
        self.link = link
    }
    
    static func getRepresentativeCollection(xmlRepresentation: NSData) -> [Representative]{
        let xml = SWXMLHash.parse(xmlRepresentation)
        var reps = [Representative]()
        
        reps = xml["result"]["rep"].all.map { elem in
            Representative(
                name: elem.element!.attributes["name"],
                party: elem.element!.attributes["party"],
                state: elem.element!.attributes["state"],
                district: elem.element!.attributes["district"],
                phone: elem.element!.attributes["phone"],
                office: elem.element!.attributes["office"],
                link: elem.element!.attributes["link"])
        }
        
        return reps
    }
}