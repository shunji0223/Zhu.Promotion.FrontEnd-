//
//  MyPromotionApp.swift
//  MyPromotion
//
//  Created by 朱駿璽 on 2021/11/27.
//

import SwiftUI

@main
struct MyPromotionAppGate: App {
    @Environment(\.scenePhase) var scenePhase
            
    private let msAuthState: MSAuthState = resolve()
    
    private let msAuthAdapter: MSAuthAdapter = resolve()
    
    var body: some Scene {
        WindowGroup {
            NoneLoginView()
                .onAppear {
                    msAuthAdapter.setupMSAuthentication()
                    msAuthAdapter.loadCurrentAccount()
                }
                .onChange(of: scenePhase) { scenePhase in
                    if scenePhase == .active {
                        msAuthAdapter.loadCurrentAccount()
                    }
                }
                .onOpenURL { url in
                    msAuthAdapter.openUrl(url: url)
                }
                .environmentObject(msAuthState)
                .environmentObject(DataModels())
            }
    }
}
