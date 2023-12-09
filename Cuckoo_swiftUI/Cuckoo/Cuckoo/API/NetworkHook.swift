//
//  NetworkHook.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Foundation
import Moya

enum API {
    // Memo
    case createMemo
    case readMemo
    case updateMemo
    case deleteMemo
    
//    // Tag
//    case createTag
//    case readTag
//    case update
//    case deleteMemo
//    
//    // Memo
//    case createMemo
//    case readMemo
//    case updateMemo
//    case deleteMemo
//    
//    // Memo
//    case createMemo
//    case readMemo
//    case updateMemo
//    case deleteMemo
    
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "http://dksu-dev.shop:8081")!
    }
    
    var path: String {
        switch self {
        case .createMemo:
            return "/users"
        case .readMemo:
            return "/memo/"
        }
    }

    // 요청 메소드 설정 (GET, POST 등)
    var method: Moya.Method {
        switch self {
        case .getUsers:
            return .get
        }
    }

    // 필요한 파라미터 설정
    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
         switch self {
         case .getUsers:
             return stubbedResponse("Users")
         }
     }

    // HTTP 헤더 설정
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

    // Alamofire를 통해 네트워크 요청
    var validationType: ValidationType {
        return .successCodes
    }
}

private func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject { }

    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}
