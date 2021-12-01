//
//  UserProfileGetApi.swift
//  MyPromotion
//
//  Created by 朱駿璽 on 2021/11/30.
//

import SwiftUI
import SwiftyJSON

struct UserProfileGetApi {
    
    @EnvironmentObject var msAuthState: MSAuthState
    @EnvironmentObject var userInfo: DataModels
    
    func GetAsync(_ after:@escaping (HTTPURLResponse) -> ()){
            let requestUrl = URL(string: "https://xxx/api/users")
            let request = NSMutableURLRequest(url: requestUrl!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue( "Bearer \(msAuthState.logMessage)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
                print(request)
                if (error == nil) {
                    if let data = data {
                        let json = try? JSON(data: data)
                        print(json!)
                        userInfo.userId = json!["userId"].stringValue
                        userInfo.familyName = json!["familyName"].stringValue
                        userInfo.givenName = json!["givenName"].stringValue
                        userInfo.dateOfBirth = DateConvertors().stringToDateConvert(datestr: json!["dateOfBirth"].stringValue)
                        userInfo.dateOfBirthStr = json!["dateOfBirth"].stringValue
                        userInfo.mailAddress = json!["mailAddress"].stringValue
                        userInfo.mobilePhoneNumber = json!["mobilePhoneNumber"].stringValue
                        userInfo.zip = json!["zip"].stringValue
                        userInfo.country = json!["country"].stringValue
                        userInfo.state = json!["state"].stringValue
                        userInfo.city = json!["city"].stringValue
                        userInfo.streetAddress1 = json!["streetAddress1"].stringValue
                        userInfo.streetAddress2 = json!["streetAddress2"].stringValue
                    } else {
                        print("No data", data as Any)
                    }
                } else {
                    print(error as Any)
                }
                
                if let response = response as? HTTPURLResponse {
                    print("get:\(response)")
                    after(response)
                }
            })
            task.resume()
        
        }
    
    func GetSync() -> DataModels? {
        
        let semaphore = DispatchSemaphore(value: 0)
        GetAsync() { (response: HTTPURLResponse) in
            semaphore.signal()
        }
        semaphore.wait()
        return userInfo
        
    }
    
}
