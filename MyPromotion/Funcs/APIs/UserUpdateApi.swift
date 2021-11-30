//
//  UserUpdateApi.swift
//  MyPromotion
//
//  Created by 朱駿璽 on 2021/11/30.
//

import SwiftUI
import SwiftyJSON

struct UserUpdateApi {
    
    @EnvironmentObject var msAuthState: MSAuthState
    
    // 登録(非同期)
    func updateAsync(userinfo: DataModels,_ after:@escaping (HTTPURLResponse) -> ()) {
        
        let requestUrl = URL(string: "https://xxx/api/users")
        
        let request = NSMutableURLRequest(url: requestUrl!)
        // set the HttpTrigger
        request.httpMethod = "PUT"
        // set the Header(s)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // set the Header(s)
        // set the BearerToken
        request.setValue( "Bearer \(msAuthState.logMessage)", forHTTPHeaderField: "Authorization")

        // set the request-body(JSON)
        let params: [String: Any] = [
            "familyName": userinfo.familyName,
            "givenName": userinfo.givenName,
            "gender": userinfo.gender,
            "dateOfBirth": DateConvertors().stringToDateConvert(datestr : userinfo.dateOfBirthStr),
            "zip": userinfo.zip,
            "country": userinfo.country,
            "state": userinfo.state,
            "city": userinfo.city,
            "streetAddress1": userinfo.streetAddress1,
            "streetAddress2": userinfo.streetAddress2,
            "mailAddress": userinfo.mailAddress,
            "mobilePhoneNumber": userinfo.mobilePhoneNumber,
        ]

        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        }catch{
            print(error.localizedDescription)
            //TODO エラーハンドリング
        }
        
        // use NSURLSessionDataTask
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            print(request)
            DispatchQueue.global().async {
                if let response = response as? HTTPURLResponse {
                    print("registration:\(response.statusCode)")
                    after(response)
                }
            }
        })
        task.resume()
    }
    // 登録(同期)
    func updateSync(userinfo: DataModels) -> HTTPURLResponse? {
        var result: HTTPURLResponse?
        let semaphore = DispatchSemaphore(value: 0)
        updateAsync(userinfo : userinfo) { (response: HTTPURLResponse) in
            result = response
            semaphore.signal()
        }
        semaphore.wait()
        return result
    }
    
}
