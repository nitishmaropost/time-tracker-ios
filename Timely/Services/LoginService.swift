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
    
    func login(requestDict: [String: String], completion: @escaping (LoginResult) -> ()) {
     
        AF.request("\(TimelyUrls.shared.kServerUrl)\(TimelyUrls.shared.kLoginUrl)", method: .post, parameters: requestDict, encoding: JSONEncoding.default, headers: TimelyUrls.shared.HEADER).responseObject { (response: DataResponse<User>) in
            print(response.result)
        }
        
//        AF.request("\(TimelyUrls.shared.kServerUrl)\(TimelyUrls.shared.kLoginUrl)", method: .post, parameters: requestDict, encoding: JSONEncoding.default, headers: TimelyUrls.shared.HEADER).responseJSON { (response) in
//            print(response)
//        }
    }
    
}
