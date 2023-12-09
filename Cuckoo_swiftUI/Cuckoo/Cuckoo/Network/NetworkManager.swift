//
//  NetworkManager.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Moya

//let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
//let loggerPlugin = NetworkLoggerPlugin(configuration: loggerConfig)

class NetworkManager {
    static let shared = NetworkManager()
    let memo_provider = MoyaProvider<MemoAPI>()//(plugins:[loggerPlugin])

    // 공통 네트워크 요청 로직
}

extension TargetType {
    var baseURL: URL {
        return URL(string: "http://dksu-dev.shop:8081")!
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

    var validationType: ValidationType {
        return .successCodes
    }
}
