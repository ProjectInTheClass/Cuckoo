//
//  LocalNotification.swift
//  Cuckoo
//
//  Created by 유철민 on 12/17/23.
//
import Foundation
import SwiftUI
import UserNotifications
import CoreLocation
import CoreData

///1. 메모 생성, 수정 여부 확인
///1-1. 메모가 처음 생성되었다. =>
///
///
///1-2. 메모가 수정되었다. => 있던 알림 전부 제거하고 다시 알림을 재세팅한다!!

class NotificationManager {
    
    //다른데서 이용을 위해 제작한 인스턴스
    static let shared = NotificationManager()
    
    @StateObject var notiLogViewModel = NotificationLogViewModel.shared
    @StateObject var memoViewModel = MemoViewModel.shared
    let container: NSPersistentContainer = CoreDataManager.shared.persistentContainer
    
    
    //알림을 위한 권한 요청 함수. 이에 대한 안내가 뜨게 해야함.
    func requestAuthorization() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("권한 설정 완료")
            }
        }
    }
    
    func getMemosForAlarmTime(alarmTimeString: String) -> [MemoEntity] {
        let context = container.viewContext //이게 맞나 확인도 해야 됨.

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "your_date_format" // 날짜 형식에 따라 적절한 포맷을 설정해야 합니다.

        guard let alarmTime = dateFormatter.date(from: alarmTimeString) else {
            print("Error converting string to date")
            return []
        }

        let fetchRequest: NSFetchRequest<MemoEntity> = MemoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "preset.alarm_time == %@", alarmTime as CVarArg)

        do {
            let memos = try context.fetch(fetchRequest)
            return memos
        } catch {
            print("Error fetching memos: \(error.localizedDescription)")
            return []
        }
    }
    
    
    //진짜 알림만 등록하는 함수 : notiInput 유형은 알아서 조정하기!!
    func createNotification(notiInput : notiInput) {
        
        let content = UNMutableNotificationContent()
        
        if(notiInput.noti_type == "periodAlert"){
            content.title = "메모 알림이 도착했어요!"
            content.subtitle = notiInput.title + " (" + String(notiInput.noti_count) + "번째 알림) "// 이 title은 메모 제목입니다.
            content.sound = .default
            content.badge = 1 // 차후 수정 가능!
        }
        
        else if(notiInput.noti_type == "preAlert"){
            content.title = "메모 알림이 설정됐어요!"
            content.subtitle = "'" + notiInput.title + "'"// 이 title은 메모 제목입니다.
            content.sound = .default
            content.badge = 1 // 차후 수정 가능!
        }
        
        var trigger = UNCalendarNotificationTrigger(dateMatching: notiInput.dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }
    
    //전부 알림 삭제
    func cancelAllNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    //추적이 가능할지는 모르겠다...
    func cancelNotification(memoId: NSManagedObjectID){
        //memoID를 이용해 notiLog에 대해 전부 삭제
        
    }
    
    //프리셋 수정에 의한 changeNotification
    func changeNotification(memoId: NSManagedObjectID){
        //프리셋 데이터
    }
    
    //알림에서 선택에 의해 userDefaults의 multiplier 선택
    func extendNotification(logID: NSManagedObjectID){
        //UserDefaults.standard.set(selectedMultiplier, forKey: "multiplier")
        let memos = notiLogViewModel.getMemosOnLog(logID: logID)
        let memo = memos?[0]
        let offset : Int?
        
        if(memo == nil){//메모 존재 안함. 알림 삭제
            notiLogViewModel.deleteLog(logID: logID)
            //notificationCenter에서도 삭제
            return
        }
        
        if let n_c = memo?.noti_count {
            
            let t : Int?
            let m : Int?
            if let term = UserDefaults.standard.string(forKey: "term") {
                t = Int(term)
                if let multiplier = UserDefaults.standard.string(forKey: "multiplier") {
                    m = Int(multiplier)
                }
                offset = (Int(n_c) + 1) * (t ?? 1) * (m ?? 1) //없으면 1로 default
            }
            
            memo?.noti_count += 1
            
            
            //새로운 notification을 만들어 올리고, 전에 있던 notification을 제거한다.
        }
    }
    
    struct LocalNotificationPractice: View {
        
        let manager = NotificationManager.shared
        
        var body: some View {
            VStack(spacing: 40) {
                Button("Request Permission") {
                    manager.requestAuthorization()
                }
                //preAlert로 trigger 만들 수 있는 예시
                
                //periodAlert로 trigger 만들 수 있는 예시
            }
            .onAppear {
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
        }
    }
    struct LocalNotificationPractice_Previews: PreviewProvider {
        static var previews: some View {
            LocalNotificationPractice()
        }
    }
}
