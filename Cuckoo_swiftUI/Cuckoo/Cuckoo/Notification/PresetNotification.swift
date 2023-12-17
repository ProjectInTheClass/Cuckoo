//
//  PresetNotification.swift
//  Cuckoo
//
//  Created by 유철민 on 12/18/23.
//

import Foundation
import CoreData

class AlarmManager {
    
    var timer: Timer?

    init() {
        // 매일 특정 시간마다 호출되도록 타이머 설정 (예: 매일 오전 8시)
        let date = Date()
        let calendar = Calendar.current
        let targetDateComponents = DateComponents(hour: 8, minute: 0, second: 0)
        guard let targetDate = calendar.date(bySettingHour: targetDateComponents.hour!, minute: targetDateComponents.minute!, second: targetDateComponents.second!, of: date) else {
            return
        }

        timer = Timer(fire: targetDate, interval: 60*60*24, repeats: true, block: { [weak self] _ in
            self?.handleAlarm()
        })

        // 타이머를 실행 루프에 추가
        if let timer = timer {
            RunLoop.current.add(timer, forMode: .default)
        }
    }

    deinit {
        // 타이머가 더 이상 필요하지 않을 때 해제
        timer?.invalidate()
    }

    @objc func handleAlarm() {
        // 매일 호출될 동작 수행
        print("Alarm time reached!")

        // AlarmPresetEntity에 등록된 시간에 해당하는 MemoEntity 가져오기
        let memoArray = getMemosForAlarmTime()
        for memo in memoArray {
            print("Memo Content: \(memo.title)")
            // 여기에서 필요한 동작 수행
        }
    }

    func getMemosForAlarmTime() -> [MemoEntity] {
        let context = // your NSManagedObjectContext

        let fetchRequest: NSFetchRequest<MemoEntity> = MemoEntity.fetchRequest()

        // 현재 날짜 및 시간 가져오기
        let currentDate = Date()

        // AlarmPresetEntity의 alarm_time과 현재 날짜 및 시간을 비교하여 조건 설정
        fetchRequest.predicate = NSPredicate(format: "memo_preset.alarm_time == %@", currentDate as CVarArg)

        do {
            let memos = try context.fetch(fetchRequest)
            return memos
        } catch {
            print("Error fetching memos: \(error.localizedDescription)")
            return []
        }
    }
}

// AlarmManager 인스턴스 생성
let alarmManager = AlarmManager()
