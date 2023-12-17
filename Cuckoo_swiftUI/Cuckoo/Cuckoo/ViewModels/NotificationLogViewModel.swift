//
//  NotificationLogViewModel.swift
//  Cuckoo
//
//  Created by DKSU on 12/17/23.
//

import Foundation
import SwiftUI
import CoreData

class NotificationLogViewModel: ObservableObject {
    static let shared = NotificationLogViewModel()
    let container: NSPersistentContainer = CoreDataManager.shared.persistentContainer
    
    @Published var logs: [NotiLogEntity] = []
    
    init() {
        fetchLog()
    }
    
    
    private func fetchLog() {
        let request = NSFetchRequest<NotiLogEntity>(entityName: "NotiLogEntity")
        
        do {
            self.logs = try container.viewContext.fetch(request)
        } catch {
            print("ERROR FETCHING CORE DATA(LOG): \(error)")
        }
    }
    
    private func save() {
        do {
            try container.viewContext.save()
            fetchLog()
        } catch {
            print("ERROR on SACING LOGS: \(error)")
        }
    }
    
    func browseLogs() {
        self.logs = []
        self.fetchLog()
        save()
    }
    
    func getLogList() -> [NotiLogEntity] {
        return self.logs
    }
    
    func getLogPreset(logID: NSManagedObjectID) -> AlarmPresetEntity? {
        let context = container.viewContext
        
        if let log = context.object(with: logID) as? NotiLogEntity {
            return log.log_preset
        }
        
        return nil
    }
    
    func getMemoCountOnLog(logID: NSManagedObjectID) -> Int {
        let context = container.viewContext
        
        let memos = getMemosOnLog(logID: logID)
        
        if let memos = memos {
            return memos.count
        }
        
        return 0
    }
    
    func getMemosOnLog(logID: NSManagedObjectID) -> [MemoEntity]? {
        let context = container.viewContext
        
        if let log = context.object(with: logID) as? NotiLogEntity {
            if let memoSet = log.log_memo as? NSOrderedSet {
                let memos = memoSet.array as? [MemoEntity]
                return memos
            }
        }
        
        return nil
    }

    
    func addLog(related_preset: AlarmPresetEntity?, memos : [MemoEntity]) {
        let newLog = NotiLogEntity(context: self.container.viewContext)
        
        
        if let log_preset = related_preset {
            newLog.log_preset = log_preset
        }
        
        for memo in memos {
            memo.addToMemo_log(newLog)
            newLog.addToLog_memo(memo)
        }
        
        newLog.sent_at = Date()
        
        save()
        fetchLog()
    }
    
    func deleteLog(logID: NSManagedObjectID) {
        let context = container.viewContext
        if let logToDelete = context.object(with: logID) as? NotiLogEntity {
            context.delete(logToDelete)
            
            do {
                try context.save()
                fetchLog()
                print("Log successfully deleted")
            } catch {
                print("Error deleting Log: \(error)")
            }
        }
    }
    
}
