//
//  Tag.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Moya

enum TagAPI {
    case createTag(params: CreateTagRequest)
    case loadTag(type: String, identifier: String)
    case updateTag(type: String, identifier: String, tag_id: Int, name: String?, color: String?)
    case deleteTag(type: String, identifier: String, tag_id: Int)
}

extension TagAPI: TargetType {
    var path: String {
        switch self {
        case .createTag, .loadTag:
            return "/tag"
        case .updateTag(_, _,let tag_id, _, _), .deleteTag(_, _, let tag_id):
            return "/tag/\(tag_id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createTag:
            return .post
        case .loadTag:
            return .get
        case .updateTag:
            return .put
        case .deleteTag:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .createTag(let params):
            return .requestJSONEncodable(params)
            
        case .loadTag(let type, let identifier):
            let params: [String: Any] = ["type": type, "identifier": identifier]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .updateTag(let type, let identifier, let tag_id, let name, let color):
            var params: [String: Any] = ["type": type, "identifier": identifier]
            
            if let name = name { params["name"] = name }
            if let color = color { params["color"] = color }
            
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: ["tag_id": tag_id])
            
        case .deleteTag(let type, let identifier, _):
            let parameters = ["type": type, "identifier": identifier]

            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
