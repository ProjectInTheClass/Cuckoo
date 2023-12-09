//
//  AlarmPresetViewModel.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Foundation


class AlarmPresetViewModel: ObservableObject {
    @Published private var presets: [AlarmPreset]
    
    init() {
        self.presets = [
            AlarmPreset(id: 1, preset_name:"아침 시간대", preset_icon:"🌞", preset_time:"08:00:00"),
            AlarmPreset(id: 2, preset_name:"저녁 시간대", preset_icon:"🌙", preset_time:"23:00:00"),
        ]
    }
    
    private func requestUserPreset(uuid: String) -> [AlarmPreset] {
        // 서버에 GET 요청 보내고 응답 받기 : Alamofire로 구현 필요
        // 실제 앱에서는 HTTP 요청을 처리하는 로직이 필요함
        // 여기에서는 예시 응답을 반환함 (Dummy)
        return [
            AlarmPreset(id: 1, preset_name:"기상시간", preset_icon:"🔔", preset_time:"07:00:00"),
            AlarmPreset(id: 2, preset_name:"아침 시간대", preset_icon:"🌞", preset_time:"08:00:00"),
            AlarmPreset(id: 3, preset_name:"저녁 시간대", preset_icon:"🌙", preset_time:"23:00:00"),
            AlarmPreset(id: 4, preset_name:"운동 갈 시간", preset_icon:"🏃", preset_time:"17:00:00"),
            AlarmPreset(id: 5, preset_name:"수업 시작", preset_icon:"🧑‍💻", preset_time:"09:00:00"),
        ]
    }
    
    func browseAlarmPresetFromServer(uuid: String!) {
        /// TODO : 서버에서 사용자 Preset 불러오기
        let response: [AlarmPreset] = requestUserPreset(uuid: uuid)
        
        /// GET /preset
        /// queryString : type=uuid&identifier={uuid}
        
        self.presets = response
    }
    
    func getAlarmPresetList() -> [AlarmPreset] {
        return self.presets
    }
    
    func addAlarmPreset(uuid: String!, name: String, icon: String, time: String) {
        /// TODO :: User의 UUID와 Alarm Preset 정보 받고 처리

        /// POST /preset
        /// body : type, identifier, name, icon, alarm_time
        /// - type은 "uuid" 고정, identifier에는 uuid 값을 넣으면 됨. (doc 참고)
        /// - alarm_time 형식 -> "HH:MM:SS" (10 미만이면 0 끼워 넣어야함 ex: "08:00:00")

        /// 성공적으로 추가했다면, 응답에서 id을 반환받아서, AlarmPreset 객체를 새로 정의해서 presets 배열에 넣고
        /// 실패했다면 alert 등을 띄우기
    }
    
    func editAlarmPreset(uuid: String!, preset_id: Int, name: String?, icon: String?, alarm_time: String?) {
        /// TODO :: User의 UUID와 Alarm Preset 정보 받고 처리

        /// PUT /preset/:preset_id
        /// queryString : type=uuid&identifier={uuid}
        /// body: 수정되는 부분만 body에 담아서 보내면 됨
        ///  ex: { title: "수정할 제목" }

        /// 성공적으로 수정했다면, 수정한 부분만 값 반영
        /// 실패했다면 alert 등을 띄우기
    }
    
    func deleteAlarmPreset(uuid: String!, preset_id: Int) {
        /// TODO :: User의 UUID와 preset_id를 받아서 삭제

        /// DELETE /preset/:preset_id
        /// queryString : type=uuid&identifier={uuid}

        /// 성공적으로 삭제했다면, 리스트에서 메모 삭제
        /// 실패했다면 alert 등을 띄우기
    }
}
