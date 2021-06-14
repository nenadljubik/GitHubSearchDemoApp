//
//  Router.swift
//  GitHubRepoSearch
//
//  Created by Ненад Љубиќ on 13.6.21.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {

    case GetRepos(query: String)

    var method: Alamofire.HTTPMethod {
        switch self {
        case .GetRepos:
            return .get
        }
    }

    var path: String {
        switch self {
        case .GetRepos(let query):
            return (Constant.Network.baseUrl + Constant.Network.Endpoints.searchRepos + "?q=\(query)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? Constant.Network.baseUrl + Constant.Network.Endpoints.searchRepos
        }
    }

    var parameters: [String : Any] {
        switch self {
        default:
            return [:]
        }
    }

    var header : [String: String] {
        return [
            "Content-Type" : "application/json"
        ]
    }

    func asURLRequest() throws -> URLRequest {
        var url: URL!
        url = URL(string: path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        if method.rawValue != "GET" {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: self.parameters, options: .prettyPrinted)
        }

        urlRequest.allHTTPHeaderFields = header
        return urlRequest
    }
}
