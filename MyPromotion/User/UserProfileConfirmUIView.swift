//
//  UserProfileConfirmUIView.swift
//  MyPromotion
//
//  Created by 朱駿璽 on 2021/11/29.
//

import SwiftUI

struct UserProfileConfirmUIView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject var userInfo: DataModels
    
    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    Form{
                        Section {
                            Text("\(userInfo.familyName)　\(userInfo.givenName)")
                        }header: {
                            Text("氏名：").fontWeight(.heavy)
                        }
                        
                        Section {
                            Text("\(userInfo.gender)")
                        }header: {
                            Text("性別：").fontWeight(.heavy)
                        }
                        
                        Section {
                            Text("\(userInfo.dateOfBirthStr)")
                        }header: {
                            Text("生年月日：").fontWeight(.heavy)
                        }
                        
                        Section {
                            Text("メール：\(userInfo.mailAddress)")
                            Text("電　話：\(userInfo.mobilePhoneNumber)")
                        }header: {
                            Text("連絡先：").fontWeight(.heavy)
                        }
                        
                        Section {
                            Text("〒：\(userInfo.zip)")
                            Text("\(userInfo.country)　\(userInfo.state)　\(userInfo.city)")
                            if (userInfo.streetAddress2 != ""){
                                Text("\(userInfo.streetAddress1)　\(userInfo.streetAddress2)")
                            } else {
                                Text("\(userInfo.streetAddress1)")
                            }
                            
                        }header: {
                            Text("住所：").fontWeight(.heavy)
                        }
                    }
                }
                HStack{
                    Button("修正"){
                        self.presentation.wrappedValue.dismiss()
                    }
                    .buttonStyle(MyButtonStyle())
                    .padding()
                    
                    Spacer()
                    
                    Button("登録"){
                        
                    }
                    .buttonStyle(MyButtonStyle())
                    .padding()
                }
            }
            .navigationBarTitle(Text("プロフィール情報確認").fontWeight(.heavy))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct UserProfileConfirmUIView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileConfirmUIView()
            .environmentObject(DataModels())
    }
}
