//
//  UserRegistrationUIView.swift
//  MyPromotion
//
//  Created by 朱駿璽 on 2021/11/27.
//

import SwiftUI

struct UserProfileUIView: View {
    
    //テキストフィールド変数名設定
    @State private var familyName = ""
    @State private var givenName = ""
    @State var showGenderPicker = false
    @State private var gender = ""
    @State var showDatePicker = false
    @State private var dateOfBirth = Date()
    @State private var dateOfBirthStr = ""
    @State private var mailAddress = ""
    @State private var mobilePhoneNumber = ""
    @State private var zip = ""
    @State private var country = ""
    @State private var state = ""
    @State private var city = ""
    @State private var streetAddress1 = ""
    @State private var streetAddress2 = ""
    @State private var isActive = false
    
    @EnvironmentObject var userInfo: DataModels

    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    ScrollView{
                        Group{
                            VStack(spacing: 3){
                                HStack{
                                    Text("氏名（姓）：")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .padding(5)
                                    Spacer()
                                }
                                HStack{
                                    TextField("氏名（姓）", text: $familyName)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(5)
                                }
                            }
                            VStack(spacing: 3){
                                HStack{
                                    Text("氏名（名）：")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .padding(5)
                                    Spacer()
                                }
                                HStack{
                                    TextField("氏名（名）", text: $givenName)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(5)
                                }
                            }
                            VStack(spacing: 3){
                                HStack{
                                    Text("性別：")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .padding(5)
                                    Spacer()
                                }
                                HStack{
                                    TextField.init("性別", text: $gender, onEditingChanged:
                                                    { (editting) in
                                                        self.showGenderPicker = editting
                                                    })
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(5)
                                    if self.showGenderPicker {
                                        Button(action:{
                                            self.showGenderPicker = false
                                        }){
                                            Text("Done")
                                        }
                                        Picker(selection: $gender, label: Text("性別")) {
                                            Text("Unknown").tag("Unknown")
                                            Text("Female").tag("Female")
                                            Text("Male").tag("Male")
                                        }
                                        .pickerStyle(WheelPickerStyle())
                                    }
                                }
                            }
                            VStack(spacing: 3){
                                HStack{
                                    Text("生年月日：")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .padding(5)
                                    Spacer()
                                }
                                HStack{
                                    TextField.init("生年月日", text: $dateOfBirthStr, onEditingChanged:
                                                    { (editting) in
                                                        self.showDatePicker = editting
                                                    })
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(5)
                                    if self.showDatePicker {
                                        Button(action:{
                                            self.showDatePicker = false
                                            self.dateOfBirthStr = DateConvertors().dateToStringConvert(date: self.dateOfBirth)
                                        }){
                                            Text("Done")
                                        }
                                        DatePicker("dateOfBirth", selection: $dateOfBirth, displayedComponents: .date)
                                            .datePickerStyle(WheelDatePickerStyle())
                                    }
                                }
                            }
                        }
                        Group{
                            VStack(spacing: 3){
                                HStack{
                                    Text("メールアドレス：")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .padding(5)
                                    Spacer()
                                }
                                HStack{
                                    TextField("📧", text: $mailAddress)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.emailAddress)
                                        .padding(5)
                                }
                            }
                            VStack(spacing: 3){
                                HStack{
                                    Text("電話番号：")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .padding(5)
                                    Spacer()
                                }
                                HStack{
                                    TextField("☎️", text: $mobilePhoneNumber)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.phonePad)
                                        .padding(5)
                                }
                            }
                        }
                        Group{
                            VStack(spacing: 3){
                                HStack{
                                    Text("郵便番号：")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .padding(5)
                                    Spacer()
                                }
                                HStack{
                                    TextField("〒", text: $zip)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.numberPad)
                                        .padding(5)
                                }
                            }
                            VStack(spacing: 3){
                                HStack{
                                    Text("国：")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .padding(5)
                                    Spacer()
                                }
                                HStack{
                                    TextField("国", text: $country)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(5)
                                }
                            }
                            VStack(spacing: 3){
                                HStack{
                                    Text("都道府県：")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .padding(5)
                                    Spacer()
                                }
                                HStack{
                                    TextField("都道府県", text: $state)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(5)
                                }
                            }
                            VStack(spacing: 3){
                                HStack{
                                    Text("市区町村：")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .padding(5)
                                    Spacer()
                                }
                                HStack{
                                    TextField("市区町村", text: $city)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(5)
                                }
                            }
                            VStack(spacing: 3){
                                HStack{
                                    Text("住所１：")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .padding(5)
                                    Spacer()
                                }
                                HStack{
                                    TextField("住所１", text: $streetAddress1)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(5)
                                }
                            }
                            VStack(spacing: 3){
                                HStack{
                                    Text("住所２：")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .padding(5)
                                    Spacer()
                                }
                                HStack{
                                    TextField("住所２", text: $streetAddress2)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(5)
                                }
                            }
                        }
                    }
                }
                VStack{
                    HStack{
                        Button("クリア"){
                            self.familyName = ""
                            self.givenName = ""
                            self.gender = ""
                            self.dateOfBirthStr = ""
                            self.mailAddress = ""
                            self.mobilePhoneNumber = ""
                            self.zip = ""
                            self.country = ""
                            self.state = ""
                            self.city = ""
                            self.streetAddress1 = ""
                            self.streetAddress2 = ""
                        }
                        .buttonStyle(MyButtonStyle())
                        .padding()
                        Button("確　認"){
                            userInfo.familyName = self.familyName
                            userInfo.givenName = self.givenName
                            userInfo.gender = self.gender
                            userInfo.dateOfBirthStr = self.dateOfBirthStr
                            userInfo.mailAddress = self.mailAddress
                            userInfo.mobilePhoneNumber = self.mobilePhoneNumber
                            userInfo.zip = self.zip
                            userInfo.country = self.country
                            userInfo.state = self.state
                            userInfo.city = self.city
                            userInfo.streetAddress1 = self.streetAddress1
                            userInfo.streetAddress2 = self.streetAddress2
                            self.isActive = true
                        }
                        .disabled(self.familyName.isEmpty || self.givenName.isEmpty)
                        .fullScreenCover(isPresented: self.$isActive){
                            UserProfileConfirmUIView()
                        }
                        .buttonStyle(MyButtonStyle())
                        .padding()
                    }
                }
            }
            .background(
                Image("01")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            .navigationBarTitle(Text("プロフィール").fontWeight(.heavy))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct UserProfileUIView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileUIView()
            .environmentObject(DataModels())
    }
}
