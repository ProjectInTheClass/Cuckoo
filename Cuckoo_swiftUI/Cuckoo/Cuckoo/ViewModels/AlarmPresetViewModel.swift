//
//  AlarmPresetViewModel.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Foundation
import Moya

class AlarmPresetViewModel: ObservableObject {
    
    @Published private var presets: [AlarmPreset]
    
    enum AlarmPresetError: String, Error {
        case presetNameExists = "Preset name already exists"
        case unknownError = "Unknown error occurred"
    }
    
    init() {
        self.presets = [
            AlarmPreset(id: 1, preset_name:"아침 시간대", preset_icon:"🌞", preset_time:"08:00:00"),
            AlarmPreset(id: 2, preset_name:"저녁 시간대", preset_icon:"🌙", preset_time:"23:00:00"),
        ]
    }
    
    private func requestUserPreset(uuid: String, completion: @escaping ([AlarmPreset]?) -> Void) {
        NetworkManager.shared.preset_provider.request(.loadAlarmPreset(
            type: "uuid", identifier: uuid
        )) { result in
            switch result {
            case .success(let response):
                do {
                    let loadAlarmPresetResponse = try JSONDecoder().decode(LoadAlarmPresetResponse.self, from: response.data)
                    let alarmPresets = loadAlarmPresetResponse.map {
                        AlarmPreset(
                            id: $0.id,
                            preset_name: $0.name,
                            preset_icon: $0.icon,
                            preset_time: $0.alarmTime,
                            created_at: ISO8601DateFormatter().date(from: $0.createdAt) ?? Date()
                        )
                    }
                    completion(alarmPresets)
                } catch {
                    print("JSON decoding error: \(error)")
                    completion(nil)
                }
            case .failure(let error):
                print("네트워크 에러: \(error)")
                completion(nil)
            }
        }
    }
    
    
    
    func browseAlarmPresetFromServer(uuid: String!) {
        //        /// TODO : 서버에서 사용자 Preset 불러오기
        //        let response: [AlarmPreset] = requestUserPreset(uuid: uuid)
        //
        //        /// GET /preset
        //        /// queryString : type=uuid&identifier={uuid}
        //
        //        self.presets = response
        
        requestUserPreset(uuid: uuid) { [weak self] alarmPresets in
            if let alarmPresets = alarmPresets {
                self?.presets = alarmPresets
            }
        }
    }
    
    func getAlarmPresetList(uuid: String) -> [AlarmPreset] {
        self.browseAlarmPresetFromServer(uuid: uuid)
        return self.presets
    }
    
    func addAlarmPreset(uuid: String!, name: String, icon: String, time: String, completion: @escaping (Result<String, Error>) -> Void) {
        /// TODO :: User의 UUID와 Alarm Preset 정보 받고 처리
        
        /// POST /preset
        /// body : type, identifier, name, icon, alarm_time
        let requestBody = CreateAlarmPresetRequest(
            type: "uuid",
            identifier: uuid,
            name: name,
            icon: icon,
            alarmTime: time
        )
        
        /// - alarm_time 형식 -> "HH:MM:SS" (10 미만이면 0 끼워 넣어야함 ex: "08:00:00")
        
        /// 성공적으로 추가했다면, 응답에서 id을 반환받아서, AlarmPreset 객체를 새로 정의해서 presets 배열에 넣고
        /// 실패했다면 alert 등을 띄우기
        ///
        NetworkManager.shared.preset_provider.request(.createAlarmPreset(params: requestBody)) { result in
            switch result {
            case .success(let response):
                do {
                    let addedAlarmPreset = try JSONDecoder().decode(AlarmPresetResponse.self, from: response.data)
                    if addedAlarmPreset.msg == "Alarm preset created and linked with user" {
                        self.browseAlarmPresetFromServer(uuid: requestBody.identifier)
                        completion(.success("Alarm preset created"))
                    }
                    else if addedAlarmPreset.msg == "Preset name already exists" {
                        completion(.failure(AlarmPresetError.presetNameExists))
                    }
                    else{
                        completion(.failure(AlarmPresetError.unknownError))
                    }
                    
                } catch {
                    print("JSON decoding error: \(error)")
                    completion(.failure(error))
                    // Handle decoding error or show an alert
                }
            case .failure(let error):
                print("Network error: \(error)")
                completion(.failure(error))
                // Handle network error or show an alert
            }
        }
        
    }
    
    func editAlarmPreset(uuid: String!, preset_id: Int, name: String?, icon: String?, alarm_time: String?, completion: @escaping (Result<String, Error>) -> Void) {
        /// TODO :: User의 UUID와 Alarm Preset 정보 받고 처리
        
        /// PUT /preset/:preset_id
        /// queryString : type=uuid&identifier={uuid}
        /// body: 수정되는 부분만 body에 담아서 보내면 됨
        ///  ex: { title: "수정할 제목" }
        
        /// 성공적으로 수정했다면, 수정한 부분만 값 반영
        /// 실패했다면 alert 등을 띄우기
        /// "Alarm preset and its references deleted successfully"
        var params: [String: Any] = ["type": "uuid", "identifier": uuid!]
        
        if let name = name { params["name"] = name }
        if let icon = icon { params["icon"] = icon }
        if let alarm_time = alarm_time { params["alarm_time"] = alarm_time }
        
        NetworkManager.shared.preset_provider.request(.updateAlarmPreset(type: "uuid", identifier: uuid, preset_id: preset_id, name: name, icon: icon, alarm_time: alarm_time)) { result in
            switch result {
            case .success(let response):
                do {
                    let editedAlarmPreset = try JSONDecoder().decode(AlarmPresetResponse.self, from: response.data)
                    if editedAlarmPreset.msg == "Alarm preset updated successfully" {
                        self.browseAlarmPresetFromServer(uuid: uuid)
                        completion(.success("Alarm preset updated"))
                    } else {
                        completion(.failure(AlarmPresetError.unknownError))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteAlarmPreset(uuid: String!, preset_id: Int, completion: @escaping (Result<String, Error>) -> Void) {
        /// TODO :: User의 UUID와 preset_id를 받아서 삭제
        
        /// DELETE /preset/:preset_id
        /// queryString : type=uuid&identifier={uuid}
        
        /// 성공적으로 삭제했다면, 리스트에서 메모 삭제
        /// 실패했다면 alert 등을 띄우기
        if(preset_id <= 2){ //2번까지는 디폴트니까 건들지 말아야 됨.
            return //귀찮,,,
        }
        
        NetworkManager.shared.preset_provider.request(.deleteAlarmPreset(type: "uuid", identifier: uuid, preset_id: preset_id)) { result in
            switch result {
            case .success(let response):
                do {
                    let deleteResponse = try JSONDecoder().decode(AlarmPresetResponse.self, from: response.data)
                    if deleteResponse.msg == "Alarm preset and its references deleted successfully" {
                        // Delete the preset from the local array
                        self.presets.removeAll { $0.id == preset_id }
                        completion(.success("Alarm preset deleted"))
                    } else {
                        completion(.failure(AlarmPresetError.unknownError))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
