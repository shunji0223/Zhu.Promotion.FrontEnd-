//
//  DataModels.swift
//  Demo
//
//  Created by 朱駿璽 on 2021/10/23.
//

import Foundation
import SwiftUI

class DataModels: ObservableObject {
    
    @Published var oid : String = ""
    @Published var userId : String = ""
    @Published var mailAddress : String = ""
    @Published var newUser : Bool = false
    @Published var familyName : String = ""
    @Published var givenName : String = ""
    @Published var gender : String = ""
    @Published var zip : String = ""
    @Published var state : String = ""
    @Published var city : String = ""
    @Published var streetAddress1 : String = ""
    @Published var streetAddress2 : String = ""
    @Published var mobilePhoneNumber : String = ""
    @Published var country : String = ""
    @Published var dateOfBirthStr : String = ""
    @Published var dateOfBirth : Date = Date()
    
}
