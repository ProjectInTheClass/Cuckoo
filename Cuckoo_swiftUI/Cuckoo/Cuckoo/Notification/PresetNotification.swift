import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var timer: Timer?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 앱이 시작될 때 타이머 시작
        startTimer()
        return true
    }
    
    func startTimer() {
        // 60초마다 타이머를 설정하여 데이터를 가져옴
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(fetchData), userInfo: nil, repeats: true)
    }
    
    @objc func fetchData() {
        // 백그라운드에서 주기적으로 실행될 코드
        print("Fetching data in the background...")
        
        // CoreData에서 AlarmPresetEntity의 alarm_time을 가져오고, 해당 시간에 맞는 MemoEntity를 가져옴
        guard let alarmTime = fetchAlarmTimeFromCoreData() else { return }
        let memosForAlarmTime = getMemosForAlarmTime(alarmTime: alarmTime)
        
        for memo in memosForAlarmTime {
            print("Memo Content: \(memo.title)")
            // 여기에서 MemoEntity에 대한 추가 동작 수행
        }
    }
    
    func fetchAlarmTimeFromCoreData() -> String? {
        // CoreData에서 AlarmPresetEntity의 alarm_time을 가져오는 코드를 작성
        // 필요에 따라 NSManagedObjectContext 등을 설정
        // 예제에서는 간략하게 표현
        let context = // your NSManagedObjectContext
        
        let fetchRequest: NSFetchRequest<AlarmPresetEntity> = AlarmPresetEntity.fetchRequest()
        
        do {
            let presets = try context.fetch(fetchRequest)
            // 여기에서 적절한 로직으로 alarm_time을 선택
            if let selectedPreset = presets.first {
                return selectedPreset.alarm_time
            }
        } catch {
            print("Error fetching alarm presets: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    // MemoEntity에서 최신 NotiLogEntity의 sent_at을 찾는 함수
    func findLatestSentDate(for memo: MemoEntity) -> Date? {
        guard let logs = memo.memo_log as? Set<NotiLogEntity>, !logs.isEmpty else {
            return nil
        }
        
        let sortedLogs = logs.sorted { $0.sent_at > $1.sent_at }
        return sortedLogs.first?.sent_at
    }

    // 메인 로직
    func filterMemosForToday(memoArray: [MemoEntity]) -> [MemoEntity] {
        let userDefaults = UserDefaults.standard
        
        // 오늘의 기준 날짜 생성
        let today = Calendar.current.startOfDay(for: Date())
        
        // 오늘에 해당하는 MemoEntity 배열 생성
        let filteredMemos = memoArray.filter { memo in
            if let latestSentDate = findLatestSentDate(for: memo) {
                // MemoEntity의 noti_count, userDefaults에서 가져온 term, multiplier 값 사용
                let term = userDefaults.integer(forKey: "term")
                let multiplier = userDefaults.integer(forKey: "multiplier")
                
                // 최신 NotiLogEntity의 sent_at에 (noti_count + 1) * term * multiplier를 더한 날짜 계산
                let nextNotificationDate = Calendar.current.date(byAdding: .day, value: (Int(memo.noti_count) + 1) * term * multiplier, to: latestSentDate)
                
                // 오늘과 계산된 날짜가 일치하면 MemoEntity를 반환
                return Calendar.current.isDate(nextNotificationDate ?? Date(), inSameDayAs: today)
            }
            
            return false
        }
        
        return filteredMemos
    }
    
    
}



//// 사용 예제
//let filteredMemos = filterMemosForToday(memoArray: yourMemoArray)
//print("Filtered Memos for Today: \(filteredMemos)")



