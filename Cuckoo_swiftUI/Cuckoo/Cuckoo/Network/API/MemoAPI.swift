//
//  Memo.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Moya

enum MemoAPI {
    case createMemo(params: CreateMemoRequest)
    case loadMemo(params: Identifier)
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
            
        case .loadMemo(let params):
            return .requestJSONEncodable(params)
            
        case .updateMemo(let type, let identifier, let memo_id, let title, let comment, let url, let thumbURL, let noti_cycle, let noti_preset):
            var parameters: [String: Any] = ["type": type, "identifier": identifier]

            if let title = title { parameters["title"] = title }
            if let comment = comment { parameters["comment"] = comment }
            if let url = url?.absoluteString { parameters["url"] = url }
            if let thumbURL = thumbURL?.absoluteString { parameters["thumbURL"] = thumbURL }
            if let noti_cycle = noti_cycle { parameters["noti_cycle"] = noti_cycle }
            if let noti_preset = noti_preset { parameters["noti_preset"] = noti_preset }

            return .requestCompositeParameters(bodyParameters: parameters, bodyEncoding: JSONEncoding.default, urlParameters: ["memo_id": memo_id])

            
        case .deleteMemo(let type, let identifier, _):
            let parameters = ["type": type, "identifier": identifier]

            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
        
    }
}
