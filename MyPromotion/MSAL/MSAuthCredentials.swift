//
//  MSAuthCredentials.swift
//  Demo
//
//  Created by 朱駿璽 on 2021/10/23.
//

import Foundation

struct MSAuthCredentials{
    static let applicationId = ""  // AzureAdB2C clientId
    static let directoryId = "" // AzureAdB2C tenantId
    static let kEndpoint = "https://%@/tfp/%@/%@" //AzureAdB2C Endpoint
    static let kTenantName = "" // Your tenant name
    static let kAuthorityHostName = "" // Your authority host name
    static let kSignupOrSigninPolicy = "" // Your userflow policy
    static let msScopes: [String] = [""] // Your Api access Url
}
