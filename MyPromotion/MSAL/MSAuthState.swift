//
//  MSAuthState.swift
//  Demo
//
//  Created by 朱駿璽 on 2021/10/23.
//

import MSAL
import Combine

class MSAuthState: ObservableObject{
    @Published var currentAccount: MSALAccount?
    @Published var logMessage = ""
}
