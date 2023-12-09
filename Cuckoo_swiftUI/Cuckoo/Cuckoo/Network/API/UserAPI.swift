//
//  User.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Moya

enum UserAPI {
    case createUser(username: String)
}

extension UserAPI: TargetType {
    var path: String{
        return "/user"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .createUser(let username):
            var params = ["username": username]
            return .requestJSONEncodable(params)
        }
    }
}


