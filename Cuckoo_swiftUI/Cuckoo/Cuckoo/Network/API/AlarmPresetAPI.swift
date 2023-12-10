//
//  AlarmPreset.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Moya 

enum AlarmPresetAPI {
    case createAlarmPreset(params: CreateAlarmPresetRequest)
    case loadAlarmPreset(type: String, identifier: String)
    case updateAlarmPreset(type: String, identifier: String, preset_id: Int, name: String?, icon: String?, alarm_time: String?)
    case deleteAlarmPreset(type: String, identifier: String, preset_id: Int)
}

extension AlarmPresetAPI : TargetType{//TargetType으로 만들어줌.
    var path: String {
        switch self {
        case .createAlarmPreset, .loadAlarmPreset:
            return "/preset"
        case .updateAlarmPreset(_, _,let preset_id, _, _, _), .deleteAlarmPreset(_, _, let preset_id):
            return "/preset/\(preset_id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createAlarmPreset:
            return .post
        case .loadAlarmPreset:
            return .get
        case .updateAlarmPreset:
            return .put
        case .deleteAlarmPreset:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .createAlarmPreset(let params):
            return .requestJSONEncodable(params)
            
        case .loadAlarmPreset(let type, let identifier):
            let params: [String: Any] = ["type": type, "identifier": identifier]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .updateAlarmPreset(let type, let identifier, let preset_id, let name, let icon, let alarm_time):
            var params: [String: Any] = ["type": type, "identifier": identifier]
            
            
            if let name = name { params["name"] = name }
            if let icon = icon { params["icon"] = icon }
            if let alarm_time = alarm_time { params["alarm_time"] = alarm_time }
            
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: ["preset_id": preset_id])
            
        case .deleteAlarmPreset(let type, let identifier, _):
            let parameters = ["type": type, "identifier": identifier]

            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
