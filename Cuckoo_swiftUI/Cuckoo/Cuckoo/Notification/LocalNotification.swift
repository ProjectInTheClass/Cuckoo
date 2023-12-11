////
////  LocalNotification.swift
////  Cuckoo
////
////  Created by 유철민 on 12/11/23.
////
//
//import Foundation
//import SwiftUI
//import UserNotifications
////import CoreLocation => 위치를 인식
//
//class NotificationManager {
//    
//    static let instance = NotificationManager()
//    private init() {}
//    
//    func requestAuthorization() {
//        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
//        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                print("Getting notification authorization SUCCESS")
//            }
//        }
//    }
//    
//    var notiDict : [String, UNCalendarNotificationTrigger]
//    
//    var trigger: UNNotificationTrigger {
//        let dateComponents = DateComponents(hour: 20, minute: 26, weekday: 2)
//        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//    }
//        
//        //    enum TriggerType: String {
//        //
//        //        case time = "time"
//        //        case calendar = "calendar"
//        //        case location = "location"
//        //
//        //        var trigger: UNNotificationTrigger {
//        //            let dateComponents = DateComponents(hour: 20, minute: 26, weekday: 2)
//        //            return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        ////            switch self {
//        ////            case .time:
//        ////                return UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        ////            case .calendar:
//        ////                let dateComponents = DateComponents(hour: 20, minute: 26, weekday: 2)
//        ////                return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        ////            case .location:
//        ////                let coordinate = CLLocationCoordinate2D(latitude: 40.0, longitude: 50.0)
//        ////                let region = CLCircularRegion(center: coordinate, radius: 100, identifier: UUID().uuidString)
//        ////                region.notifyOnExit = false
//        ////                region.notifyOnEntry = true
//        ////                return UNLocationNotificationTrigger(region: region, repeats: true)
//        ////            }
//        //        }
//        //    }
//        
//        func scheduleNotification() {
//            let content = UNMutableNotificationContent()
//            content.title = "This is my first Notification"
//            content.subtitle = "This was so easy!"
//            content.sound = .default
//            content.badge = 1
//            
//            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: self.trigger)
//            UNUserNotificationCenter.current().add(request)
//        }
//        
//        //    func scheduleNotification(trigger: TriggerType) {
//        //        let content = UNMutableNotificationContent()
//        //        content.title = "This is my first Notification"
//        //        content.subtitle = "This was so easy!"
//        //        content.sound = .default
//        //        content.badge = 1
//        //
//        //        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger.trigger)
//        //        UNUserNotificationCenter.current().add(request)
//        //    }
//        
//        
//        
//        func cancelNotification() {
//            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        }
//    }
//    
//    struct LocalNotificationBootCamp: View {
//        let manager = NotificationManager.instance
//        var body: some View {
//            VStack(spacing: 40) {
//                Button("Request Permission") {
//                    manager.requestAuthorization() // init 화면에 넣을 함수
//                }
//                Button("Schedule Notification Time") {
//                    manager.scheduleNotification(trigger: .time) //
//                }
//                Button("Schedule Notification Calendar") {
//                    manager.scheduleNotification(trigger: .calendar)
//                }
//                Button("Schedule Notification Location") {
//                    manager.scheduleNotification(trigger: .location)
//                }
//                Button("Scedule Delete") {
//                    manager.cancelNotification()
//                }
//            }
//            .onAppear {
//                UIApplication.shared.applicationIconBadgeNumber = 0
//            }
//        }
//    }
