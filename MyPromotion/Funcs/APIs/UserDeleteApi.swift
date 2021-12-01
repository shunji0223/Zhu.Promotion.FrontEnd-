//
//  UserDeleteApi.swift
//  MyPromotion
//
//  Created by 朱駿璽 on 2021/12/01.
//

import SwiftUI
import SwiftyJSON

struct UserDeleteApi {
    
    @EnvironmentObject var msAuthState: MSAuthState
    
    func DeleteAsync(userId : String, _ after:@escaping (HTTPURLResponse) -> ()) {
        
        let requestUrl = URL(string: "https://xxx/api/users/\(userId)")
        
        let request = NSMutableURLRequest(url: requestUrl!)
        // set the HttpTrigger
        request.httpMethod = "DELETE"
        // set the Header(s)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // set the Header(s)
        // set the BearerToken
        request.setValue( "Bearer \(msAuthState.logMessage)", forHTTPHeaderField: "Authorization")
        
        // use NSURLSessionDataTask
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            print(request)
            DispatchQueue.global().async {
                if let response = response as? HTTPURLResponse {
                    print("delete:\(response.statusCode)")
                    after(response)
                }
            }
        })
        task.resume()
        
    }
    
    func DeleteSync(userId : String) -> HTTPURLResponse? {
        
        var result: HTTPURLResponse?
        let semaphore = DispatchSemaphore(value: 0)
        DeleteAsync(userId : userId) { (response: HTTPURLResponse) in
            result = response
            semaphore.signal()
        }
        semaphore.wait()
        return result
        
    }
    
}
