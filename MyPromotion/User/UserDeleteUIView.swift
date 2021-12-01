//
//  UserDeleteUIView.swift
//  MyPromotion
//
//  Created by 朱駿璽 on 2021/12/01.
//

import SwiftUI

struct UserDeleteUIView: View {
    
    @EnvironmentObject var userInfo: DataModels
    @Environment(\.presentationMode) var presentation
    @State var showingAlert: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Text("退会処理を行います。")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .padding(5)
                    Divider()
                    Text("よろしいでしょうか？")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .padding(5)
                }
                VStack{
                    Spacer()
                    HStack{
                        Button("戻る"){
                            self.presentation.wrappedValue.dismiss()
                        }
                        .buttonStyle(MyButtonStyle())
                        .padding()
                        Spacer()
                        Button("退会"){
                            self.showingAlert = true
                        }
                        .buttonStyle(MyButtonStyle())
                        .padding()
                        .alert("退会確認", isPresented: $showingAlert){
                            Button("キャンセル", role: .cancel){
                            }
                            Button("退会", role: .destructive){
                                // TODO:退会処理
                            }
                        }
                    }
                }
            }
            .background(
                Image("02")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            .navigationBarTitle(Text("退会").fontWeight(.heavy))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct UserDeleteUIView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeleteUIView()
            .environmentObject(DataModels())
    }
}
