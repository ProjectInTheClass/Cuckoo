//
//  Notification.swift
//  Cuckoo
//
//  Created by 유철민 on 12/6/23.
//

import Foundation
import SwiftUI
import UserNotifications
import CoreLocation

/*
 알림 요청 허가를 받는다.
 알림을 주는 기준에 따라 트리거를 설정한다.
 알림에 따른 효과(배지 등)를 조작한다.
 */


/*
 트리거 종류에 따른 enum을 만들어 파라미터에 곧바로 기본값으로 따라오도록 구현했다.
 만일 시간, 날짜 등 커스텀할 필요가 있다면 위와 같은 연산 프로퍼티가아니라 파라미터로
 값을 전달하는 함수를 TriggerType 안에 구현하면 된다.
 알림이 오면 배지 개수를 1로 고정했는데, 기본 동작대로라면 누적 합이 옳다.
 또한 배지 카운트를 빼주는 동작을 onAppear, 즉 현재 뷰를 다시 확인하는 것을 기준으로 했는데,
 기본 동작대로라면 백그라운드 상태에서도 동작하도록 수정하면 좋을 것 같다.
 */

class NotificationManager {
    static let instance = NotificationManager()
    private init() {}
    
    //권한 요청
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("SUCCESS")
            }
        }
    }
    
    //트리거
    enum TriggerType: String {
        
        case time = "time"
        case calendar = "calendar"
        case location = "location"
        
        var trigger: UNNotificationTrigger {
            switch self {
            case .time:
                return UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            case .calendar:
                let dateComponents = DateComponents(hour: 20, minute: 26, weekday: 2)
                return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            case .location:
                let coordinate = CLLocationCoordinate2D(latitude: 40.0, longitude: 50.0)
                let region = CLCircularRegion(center: coordinate, radius: 100, identifier: UUID().uuidString)
                region.notifyOnExit = false
                region.notifyOnEntry = true
                return UNLocationNotificationTrigger(region: region, repeats: true)
            }
        }
    }
    
    
    //구성 예시
    func scheduleNotification(trigger: TriggerType) {
        let content = UNMutableNotificationContent()
        content.title = "This is my first Notification"
        content.subtitle = "This was so easy!"
        content.sound = .default
        content.badge = 1
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger.trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    //notification 제거?
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

//struct LocalNotificationBootCamp: View {
//    let manager = NotificationManager.instance
//    var body: some View {
//        VStack(spacing: 40) {
//            Button("Request Permission") {
//                manager.requestAuthorization()
//            }
//            Button("Schedule Notification Time") {
//                manager.scheduleNotification(trigger: .time)
//            }
//            Button("Schedule Notification Calendar") {
//                manager.scheduleNotification(trigger: .calendar)
//            }
//            Button("Schedule Notification Location") {
//                manager.scheduleNotification(trigger: .location)
//            }
//            Button("Scedule Delete") {
//                manager.cancelNotification()
//            }
//        }
//        .onAppear {
//            UIApplication.shared.applicationIconBadgeNumber = 0
//        }
//    }
//}

