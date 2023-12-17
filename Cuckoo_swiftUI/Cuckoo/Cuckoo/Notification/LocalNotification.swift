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
class NotificationManager {
    //공유용 객체
    static let sharedNoti = NotificationManager()
    
    private init() {}
    
    //전달용 객체
    struct notiInput{
        var title : String
        var noti_count : Int
        var noti_type : String // "byExactDate , byWeekDay"
        var dateComponents : DateComponents
    }
    
    //notiInput 형성시 프리셋의 형태를 확인해서...
    func setByExactDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> DateComponents {
        return DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)
    }
    func setByWeekDay(weekday: Int, hour: Int, minute: Int) -> DateComponents {
        return DateComponents(weekday: weekday, hour: hour, minute: minute)
    }
    
    //uuid로 coredata에서 메모를 찾아서 notiInput으로 반환하는 함수
    func makeNotiInput(uuid : UUID, dateComponents : DateComponents){
        
        //UUID로 메모 부르는 함수
        
        var noti : notiInput(title: <#T##String#>, noti_count: <#T##Int#>, noti_type: <#T##String#>, dateComponents: <#T##DateComponents#>, url: <#T##URL#>)
        
        return noti
    }
    
    //알림을 위한 권한 요청 함수 => url 링크에 대한 권한도
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
    
    
    func scheduleNotification(notiInput : notiInput) {
        
        let content = UNMutableNotificationContent()
        
        content.title = "메모 알림이 도착했어요!"
        content.subtitle = notiInput.title // 이 title은 메모 제목입니다.
        content.sound = .default
        content.badge = 1
        
        var noti_type = notiInput.noti_type
        
        UNCalendarNotificationTrigger(dateMatching: notiInput.dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger.trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func cancelAllNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    //coredata로부터 메모의 uuid를 받고 해당하는 알림 전체 삭제
    func cancelANotification(uuid : String){
        
        //coredata로부터 uuid로 시간 언젠지 확인
        
        
    }
    
    func changeNotification(uuid : String){
        //coredata 수정
        //notification center에서 수정
    }
}
struct LocalNotificationPractice: View {
    
    let manager = NotificationManager.sharedNoti
    
    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") {
                manager.requestAuthorization()
            }
            //setByExactDate로 trigger 만들 수 있는 예시
            
            //setByWeekDay로 trigger 만들 수 있는 예시
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
