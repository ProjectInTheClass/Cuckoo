//
//  Memo.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Moya

enum MemoAPI {
    case createMemo(params: CreateMemoRequest)
    case loadMemo(type: String, identifier: String)
    case updateMemo(type: String, identifier: String, memo_id: Int, title: String?, comment: String?, url: URL?, thumbURL: URL?, noti_cycle: Int?, noti_preset: Int?)
    case deleteMemo(type: String, identifier: String, memo_id: Int)
}

extension MemoAPI: TargetType {
    var path: String {
        switch self {
        case .createMemo, .loadMemo:
            return "/memo"
        case .updateMemo(_, _, let memo_id, _, _, _, _, _, _), .deleteMemo(_, _, let memo_id):
            return "/memo/\(memo_id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createMemo:
            return .post
        case .loadMemo:
            return .get
        case .updateMemo:
            return .put
        case .deleteMemo:
            return .delete
        }
    }
    
    
    var task: Task {
        switch self {
        case .createMemo(let params):
            return .requestJSONEncodable(params)
            
        case .loadMemo(let type, let identifier):
            let params: [String: Any] = ["type": type, "identifier": identifier]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .updateMemo(let type, let identifier, _, let title, let comment, let url, let thumbURL, let noti_cycle, let noti_preset):
            var parameters: [String: Any] = ["type": type, "identifier": identifier]
            var bodyParams: [String: Any] = [:]
            if let title = title { bodyParams["title"] = title }
            if let comment = comment { bodyParams["comment"] = comment }
            if let url = url?.absoluteString { bodyParams["url"] = url }
            if let thumbURL = thumbURL?.absoluteString { bodyParams["thumbURL"] = thumbURL }
            if let noti_cycle = noti_cycle { bodyParams["noti_cycle"] = noti_cycle }
            if let noti_preset = noti_preset { bodyParams["noti_preset"] = noti_preset }

            return .requestCompositeParameters(bodyParameters: bodyParams, bodyEncoding: JSONEncoding.default, urlParameters: parameters)

            
        case .deleteMemo(let type, let identifier, _):
            let parameters = ["type": type, "identifier": identifier]

            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
        
    }
}
