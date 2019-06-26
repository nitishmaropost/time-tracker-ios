//
//  LoginService.swift
//  Timely
//
//  Created by maropost on 17/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class LoginService: NSObject {
    static let shared = LoginService()
    
    func login(requestDict: [String: String], completion: @escaping (TimelyAPIResult) -> ()) {
        AF.request("\(TimelyUrls.shared.kServerUrl)\(TimelyUrls.shared.kLoginUrl)", method: .post, parameters: requestDict, encoding: JSONEncoding.default, headers: TimelyUrls.shared.HEADER).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                let user = Mapper<User>().map(JSON: response.value as! [String : Any])
                KeychainHelper.shared.setValueInKeychain(forKey: TimelyConstants.shared.token, value: user?.token ?? "")
                UserDefaults.standard.setValue(user?.userInfo?.userRole, forKey: "role")
                UserDefaults.standard.setValue(user?.userInfo?.fullName, forKey: "fullName")
                UserDefaults.standard.setValue(user?.userInfo?.email, forKey: "email")
                return completion(.success(user!))
            }
            else if response.response?.statusCode == 422 {
                return completion(.error("Invalid credentials"))
            } else if response.response == nil {
                return completion(.error("Request timeout"))
            }
        }
    }
}
