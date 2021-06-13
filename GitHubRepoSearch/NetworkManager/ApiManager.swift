//
//  ApiManager.swift
//  GitHubRepoSearch
//
//  Created by Ненад Љубиќ on 13.6.21.
//

import Foundation
import Alamofire

typealias CompletitionCallBack = ((_ success: Bool, _ responseObject: [String:Any]?,_ statusCode : Int?)-> ())?

class ApiManager {
    static let sharedInstance = ApiManager()

    private func executeRequest(request: URLRequestConvertible, completitionCallback: CompletitionCallBack) {
        AF.request(request).validate().responseJSON { (response) in
            switch response.result {
            case .success(_):
                let json = response.value as? [String:Any]
                completitionCallback!(true, json, response.response?.statusCode)
            case .failure(_):
                completitionCallback!(false, nil, response.response?.statusCode)
            }
        }
    }

    func getRepos(with query: String, completition: CompletitionCallBack) {
        executeRequest(request: Router.GetRepos(query: query), completitionCallback: completition)
    }
}
