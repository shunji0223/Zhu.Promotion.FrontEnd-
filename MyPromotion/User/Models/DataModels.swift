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
    @Published var firstName : String = ""
    @Published var middleName : String = ""
    @Published var lastName : String = ""
    @Published var secondLastName : String = ""
    @Published var zip : String = ""
    @Published var state : String = ""
    @Published var city : String = ""
    @Published var streetAddress1 : String = ""
    @Published var streetAddress2 : String = ""
    @Published var mobilePhoneNumber : String = ""
    @Published var region : String = ""
    @Published var country : String = ""
    @Published var language : String = ""
    @Published var dateOfBirth : Date = Date()
    
    var userIdGetterSetter: String{
        get {return self.userId}
        set(userId){
            self.userId = userId
        }
    }
    
    var oidGetterSetter: String{
        get {return self.oid}
        set(oid){
            self.oid = oid
        }
    }
    
    var mailAddressGetterSetter: String{
        get {return self.mailAddress}
        set(mailAddress){
            self.mailAddress = mailAddress
        }
    }
    
    var newUserGetterSetter: Bool{
        get {return self.newUser}
        set(newUser){
            self.newUser = newUser
        }
    }
    
    var firstNameGetterSetter: String {
        get {return self.firstName}
        set(firstName){
            self.firstName = firstName
        }
    }
    
    var middleNameGetterSetter: String {
        get {return self.middleName}
        set(middleName){
            self.middleName = middleName
        }
    }
    
    var lastNameGetterSetter: String {
        get {return self.lastName}
        set(lastName){
            self.lastName = lastName
        }
    }
    
    var secondLastNameGetterSetter: String {
        get {return self.secondLastName}
        set(secondLastName){
            self.secondLastName = secondLastName
        }
    }
    
    var zipGetterSetter: String {
        get {return self.zip}
        set(zip){
            self.zip = zip
        }
    }
    
    var stateGetterSetter: String {
        get {return self.state}
        set(state){
            self.state = state
        }
    }
    
    var cityGetterSetter: String {
        get {return self.city}
        set(city){
            self.city = city
        }
    }
    
    var streetAddress1GetterSetter: String {
        get {return self.streetAddress1}
        set(streetAddress1){
            self.streetAddress1 = streetAddress1
        }
    }
    
    var streetAddress2GetterSetter: String {
        get {return self.streetAddress2}
        set(streetAddress2){
            self.streetAddress2 = streetAddress2
        }
    }
    
    var mobilePhoneNumberGetterSetter: String {
        get {return self.mobilePhoneNumber}
        set(mobilePhoneNumber){
            self.mobilePhoneNumber = mobilePhoneNumber
        }
    }
    
    var regionGetterSetter: String {
        get {return self.region}
        set(region){
            self.region = region
        }
    }
    
    var countryGetterSetter: String {
        get {return self.country}
        set(country){
            self.country = country
        }
    }
    
    var languageGetterSetter: String {
        get {return self.language}
        set(language){
            self.language = language
        }
    }
    
    
    var date : Date {
        get {
            return self.dateOfBirth
        }
        set(dateOfBirth) {
            self.dateOfBirth = dateOfBirth
        }
    }
    
    
}
