//
//  NetworkConstants.swift
//  GitHubRepoSearch
//
//  Created by Ненад Љубиќ on 13.6.21.
//

import Foundation

struct Constant {
    struct Network {
        static let baseUrl = "https://api.github.com/"
        
        struct Endpoints {
            static let searchRepos = "search/repositories"
        }
    }
}
