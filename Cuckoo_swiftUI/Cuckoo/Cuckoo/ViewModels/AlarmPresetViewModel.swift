//
//  AlarmPresetViewModel.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Foundation
import CoreData

class AlarmPresetViewModel: ObservableObject {
    
    static let shared = AlarmPresetViewModel()
    let container: NSPersistentContainer = CoreDataManager.shared.persistentContainer
    
    @Published var presets: [AlarmPresetEntity] = []
    
    enum AlarmPresetError: String, Error {
        case presetNameExists = "Preset name already exists"
        case unknownError = "Unknown error occurred"
    }
    
    init() {
        fetchPreset()
        
        if presets.isEmpty {
            initPreset()
            fetchPreset()
        }
    }
    
    private func fetchPreset() {
        let request = NSFetchRequest<AlarmPresetEntity>(entityName: "AlarmPresetEntity")
        
        do {
            self.presets = try container.viewContext.fetch(request)
            self.presets.sort { $0.alarm_time < $1.alarm_time }
            
        } catch {
            print("ERROR FETCHING CORE DATA(Preset): \(error)")
        }
    }
    
    private func save() {
        do {
            try container.viewContext.save()
            fetchPreset()
        } catch {
            print("ERROR on SAVING Preset: \(error)")
        }
    }
    
    func browsePresets() {
        self.presets = []
        self.fetchPreset()
        save()
    }
    
    func getPresetList() -> [AlarmPresetEntity] {
        return self.presets
    }
    
    func initPreset() {
        let morningPreset = AlarmPresetEntity(context: self.container.viewContext)
        morningPreset.name = "아침 시간대"
        morningPreset.icon = "🌞"
        morningPreset.alarm_time = "07시 30분"
        
        let nightPreset = AlarmPresetEntity(context: self.container.viewContext)
        nightPreset.name = "저녁 시간대"
        nightPreset.icon = "🌙"
        nightPreset.alarm_time = "10시 30분"
        
        save()
    }
    
    func addAlarmPreset(icon: String, name: String, time: String) {
        
        let newPreset = AlarmPresetEntity(context: self.container.viewContext)
        newPreset.name = name
        newPreset.icon = icon
        newPreset.alarm_time = time
        newPreset.created_at = Date()
        newPreset.updated_at = Date()
        
        save()
        fetchPreset()
    }
    
    func editAlarmPreset(presetID: NSManagedObjectID, icon: String?, name: String?, time: String?) {
        let context = container.viewContext
        if let presetToEdit = context.object(with: presetID) as? AlarmPresetEntity {
            
            
            if let name = name {
                presetToEdit.name = name
            }
            
            if let icon = icon {
                presetToEdit.icon = icon
            }
            
            if let time = time {
                presetToEdit.alarm_time = time
            }
            
            presetToEdit.updated_at = Date()
        }
        
        save()
        fetchPreset()
    }
    
    func deleteAlarmPreset(presetID: NSManagedObjectID) {
        let context = container.viewContext
        if let presetToDelete = context.object(with: presetID) as? AlarmPresetEntity {
            context.delete(presetToDelete)
            do {
                try context.save()
                fetchPreset() // 목록 업데이트
                print("Preset successfully deleted.")
            } catch {
                print("Error deleting Preset: \(error)")
            }
        }
    }
}
