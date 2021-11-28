//
//  MSAuthAdapter.swift
//  Demo
//
//  Created by 朱駿璽 on 2021/10/23.
//

import Foundation
import MSAL
import os.log
import JWTDecode
import SwiftUI

class MSAuthAdapter {
    
    /*
    private let msGraphEndpoint = "https://ZhuPerson.onmicrosoft.com/b2cbdec9-255d-4cdd-a183-1ef912b686c6/Api"
    private let msAuthority: String = "https://zhuperson.onmicrosoft.com/\(MSAuthCredentials.directoryId)"
    private let msRedirectUri = "msauth.\(Bundle.main.bundleIdentifier!)://auth"
    private let msScopes: [String] = ["https://ZhuPerson.onmicrosoft.com/b2cbdec9-255d-4cdd-a183-1ef912b686c6/Api/read"]

    private let msAuthState: MSAuthState = resolve()

    private var accessToken = ""
    private var applicationContext: MSALPublicClientApplication?
     */
    private let msAuthState: MSAuthState = resolve()
    private var webViewParamaters: MSALWebviewParameters?
    private let msScopes: [String] = ["https://mcbetab2bpoc.onmicrosoft.com/ac847304-2c82-42fc-99a3-abce40f62ee5/api/Files.Read"]
    private var accessToken = ""
    private var applicationContext: MSALPublicClientApplication?
    
    let kEndpoint = "https://%@/tfp/%@/%@"
    //azureストレージから取得するようにやってみる
    let kTenantName = "mcbetab2bpoc.onmicrosoft.com" // Your tenant name
    let kAuthorityHostName = "mcbetab2bpoc.b2clogin.com" // Your authority host name
    let kClientID = "ac847304-2c82-42fc-99a3-abce40f62ee5" // Your client ID from the portal when you created your application
    let kRedirectUri = "msauth.com.microsoft.identitysample.MSALiOS://auth" // Your application's redirect URI
    let kSignupOrSigninPolicy = "B2C_1_alt_enter_01" // Your signup and sign-in policy you created in the portal
    let kEditProfilePolicy = "B2C_1_alt_enter_01" // Your edit policy you created in the portal
    let kResetPasswordPolicy = "B2C_1_alt_enter_01" // Your reset password policy you created in the portal
    let kGraphURI = "https://mcbetab2bpoc.onmicrosoft.com/ac847304-2c82-42fc-99a3-abce40f62ee5/api" // This is your backend API that you've configured to accept your app's tokens
    let kScopes: [String] = ["https://mcbetab2bpoc.onmicrosoft.com/ac847304-2c82-42fc-99a3-abce40f62ee5/api/Files.Read"] // This is a scope that you've configured your backend API to look for.
    
    
    private var application: MSALPublicClientApplication!
    
    init() {
        do {
            let siginPolicyAuthority = try self.getAuthority(forPolicy: self.kSignupOrSigninPolicy)
            let pcaConfig = MSALPublicClientApplicationConfig(clientId: kClientID, redirectUri: nil, authority: siginPolicyAuthority)
            pcaConfig.knownAuthorities = [siginPolicyAuthority]
            self.application = try MSALPublicClientApplication(configuration: pcaConfig)
        } catch {
            print("Unable to create application \(error)")
        }
    }

    /// needs to be called after the view was initialised so the topViewController can be found
    func setupMSAuthentication() {
        if let topViewController = topViewController() {
            self.webViewParamaters = MSALWebviewParameters(authPresentationViewController: topViewController)
        }
    }

    //ここはB2C呼び出す処理
    func callGraphAPI(dataset: DataModels) {
        
        do {
            let authority = try self.getAuthority(forPolicy: self.kSignupOrSigninPolicy)
            //guard let applicationContext = self.applicationContext else { return }
            guard let webViewParameters = self.webViewParamaters else { return }
            let parameters = MSALInteractiveTokenParameters(scopes: msScopes, webviewParameters: webViewParameters)
            parameters.promptType = .selectAccount
            parameters.authority = authority

                application.acquireToken(with: parameters) { (result, error) in
                guard let result = result else {
                    return
                }
                let accessToken = result.accessToken
                print("accessToken=\(accessToken)")
                    guard let jwt = try? decode(jwt: accessToken) else {return}
                    guard let oidjwt = jwt.body["oid"] as? String else {return}
                    /*
                    guard let emails = jwt.body["emails"] as? Array<Any> else {
                        return
                    }
                     */
                    let newUserjwt = (jwt.body["newUser"] as? Bool) ?? false
                          
                    
                    print("oid:\(oidjwt)")
                    
                    dataset.oid = oidjwt
                    //dataset.mailAddress = (emails[0] as AnyObject).description
                    dataset.newUser = newUserjwt
                    self.msAuthState.logMessage = result.accessToken
                    
            }
        }catch {
                print("error") /* MSALPublicClientApplication creation failed, check error information */
            }
    }

    func loadCurrentAccount(completion: ((MSALAccount?) -> Void)? = nil) {
        guard let applicationContext = applicationContext else { return }

        let msalParameters = MSALParameters()
        msalParameters.completionBlockQueue = DispatchQueue.main

        applicationContext.getCurrentAccount(with: msalParameters) { (currentAccount, _, error) in

            if let error = error {
                self.msAuthState.logMessage = "Couldn't query current account with error: \(error)"
                print(self.msAuthState.logMessage + "loadcurrentaccount1")
                return
            }

            if let currentAccount = currentAccount {
                self.msAuthState.logMessage = "Found a signed in account \(String(describing: currentAccount.username)). Updating data for that account..."
                print(self.msAuthState.logMessage + "loadcurrentaccount2")
                self.msAuthState.currentAccount = currentAccount
                completion?(currentAccount)
                return
            }

            self.msAuthState.logMessage = "Account signed out. Updating UX"
            print(self.msAuthState.logMessage + "loadcurrentaccount3")
            self.accessToken = ""
            self.msAuthState.currentAccount = nil

            if let completion = completion {
                completion(nil)
            }
        }
    }

    func signOut() {
        guard let applicationContext = applicationContext else { return }
        guard let account = msAuthState.currentAccount else { return }

        let signoutParameters = MSALSignoutParameters(webviewParameters: webViewParamaters!)
        signoutParameters.signoutFromBrowser = false

        applicationContext.signout(with: account, signoutParameters: signoutParameters) { (_, error) in
            if let error = error {
                self.msAuthState.logMessage = "Couldn't sign out account with error: \(error)"
                print(self.msAuthState.logMessage + "signout1")
                return
            }

            self.msAuthState.logMessage = "Sign out completed successfully"
            print(self.msAuthState.logMessage + "signout2")
            self.accessToken = ""
            self.msAuthState.currentAccount = nil
        }
    }
    
    func getDeviceMode() {
        self.applicationContext?.getDeviceInformation(with: nil) { (deviceInformation, error) in
            
            guard let deviceInfo = deviceInformation else {
                self.msAuthState.logMessage = "Device info not returned. Error: \(String(describing: error))"
                return
            }
            
            let deviceMode = deviceInfo.deviceMode == .shared ? "shared" : "private"
            self.msAuthState.logMessage = "Received device info. Device is in the \(deviceMode) mode."
            print(self.msAuthState.logMessage + "getDeviceMode1")
        }
    }

    func openUrl(url: URL) {
        // as the onOpenURL modifier does not provide a sourceApplication, i set it to nil.
        // Though I think opening the app with a link is not necessary for this example
        MSALPublicClientApplication.handleMSALResponse(url, sourceApplication: nil)
    }
    
    func getAuthority(forPolicy policy: String) throws -> MSALB2CAuthority {
        guard let authorityURL = URL(string: String(format: self.kEndpoint, self.kAuthorityHostName, self.kTenantName, policy)) else {
            throw NSError(domain: "SomeDomain",
                          code: 1,
                          userInfo: ["errorDescription": "Unable to create authority URL!"])
        }
        return try MSALB2CAuthority(url: authorityURL)
    }

/*
    private func acquireTokenInteractively() {
        guard let applicationContext = self.applicationContext else { return }
        guard let webViewParameters = self.webViewParamaters else { return }
        do {
            let authority = try self.getAuthority(forPolicy: self.kSignupOrSigninPolicy)
            let parameters = MSALInteractiveTokenParameters(scopes: msScopes, webviewParameters: webViewParameters)
            parameters.promptType = .selectAccount
            parameters.authority = authority

            applicationContext.acquireToken(with: parameters) { (result, error) in
                if let error = error {
                    self.msAuthState.logMessage = "Could not acquire token: \(error)"
                    print(self.msAuthState.logMessage + "acquireTokenInteractively1")
                    return
                }

                guard let result = result else {
                    self.msAuthState.logMessage = "Could not acquire token: No result returned"
                    print(self.msAuthState.logMessage + "acquireTokenInteractively2")
                    return
                }

                self.accessToken = result.accessToken
                self.msAuthState.logMessage = "Access token is \(self.accessToken)"
                print(self.msAuthState.logMessage + "acquireTokenInteractively3")
                self.msAuthState.currentAccount = result.account
                self.getContentWithToken()
            }
        } catch {
            print("error")
        }
        
        
    }
    */
/*
    private func acquireTokenSilently(_ account: MSALAccount!) {
        guard let applicationContext = applicationContext else { return }

        let parameters = MSALSilentTokenParameters(scopes: msScopes, account: account)

        applicationContext.acquireTokenSilent(with: parameters) { (result, error) in

            if let error = error {
                let nsError = error as NSError
                if nsError.domain == MSALErrorDomain && nsError.code == MSALError.interactionRequired.rawValue {
                    DispatchQueue.main.async {
                        self.acquireTokenInteractively()
                    }
                    return
                }

                self.msAuthState.logMessage = "Could not acquire token silently: \(error)"
                print(self.msAuthState.logMessage + "acquireTokenSilently1")
                return
            }

            guard let result = result else {
                self.msAuthState.logMessage = "Could not acquire token: No result returned"
                print(self.msAuthState.logMessage + "acquireTokenSilently2")
                return
            }

            self.accessToken = result.accessToken
            self.msAuthState.logMessage = "Refreshed Access token is \(self.accessToken)"
            print(self.msAuthState.logMessage + "acquireTokenSilently3")
            self.getContentWithToken()
        }
    }
*/
    /*
    private func getContentWithToken() {
        var request = URLRequest(url: URL(string: msGraphEndpoint)!)

        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                self.msAuthState.logMessage = "Couldn't get graph result: \(error)"
                print(self.msAuthState.logMessage + "getContentWithToken1")
                return
            }

            guard let result = try? JSONSerialization.jsonObject(with: data!, options: []) else {

                self.msAuthState.logMessage = "Couldn't deserialize result JSON"
                print(self.msAuthState.logMessage + "getContentWithToken2")
                return
            }

            self.msAuthState.logMessage = "Result from Graph: \(result))"
            print(self.msAuthState.logMessage + "getContentWithToken3")
        }.resume()
    }
     */
}

private func topViewController() -> UIViewController? {
    let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
    let rootVC = window?.rootViewController
    return rootVC?.top()
}

private extension UIViewController {
    func top() -> UIViewController {
        if let nav = self as? UINavigationController {
            return nav.visibleViewController?.top() ?? nav
        } else if let tab = self as? UITabBarController {
            return tab.selectedViewController ?? tab
        } else {
            return presentedViewController?.top() ?? self
        }
    }
}
