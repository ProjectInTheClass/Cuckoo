//
//  TagViewModel.swift
//  Cuckoo
//
//  Created by DKSU on 12/16/23.
//

import Foundation
import CoreData

class TagViewModel: ObservableObject {
    static let shared = TagViewModel()
    let container: NSPersistentContainer = CoreDataManager.shared.persistentContainer
    
    @Published var tags: [TagEntity] = []
    
    init() {
        fetchTag()
    }
    
    private func fetchTag() {
        let request = NSFetchRequest<TagEntity>(entityName: "TagEntity")
        
        do {
            self.tags = try container.viewContext.fetch(request)
        } catch {
            print("ERROR FETCHING CORE DATA(TAG): \(error)")
        }
    }
    
    // 2. Core Data 저장하기
    private func save() {
        do {
            try container.viewContext.save()
            fetchTag()
        } catch {
            print("ERROR on SAVING TAGS: \(error)")
        }
    }
    
    func browseTags() {
//        self.tags = []
        self.fetchTag()
        save()
    }
    
    func getTagList() -> [TagEntity] {
        return self.tags
    }
    
    func addTag(name: String, color: String) {
        // TODO :: color가 6자리 색깔 값인지 확인하는 logic 필요
        
        let newTag = TagEntity(context: self.container.viewContext)
        newTag.name = name
        newTag.color = color
        
        save()
        fetchTag()
    }
    
    func editTag(tag_id: NSManagedObjectID, name: String?, color: String?) {
        // TODO :: color가 6자리 색깔 값인지 확인하는 logic 필요
        let context = container.viewContext
        
        if let tagToEdit = context.object(with: tag_id) as? TagEntity {
            if let name = name {
                tagToEdit.name = name
            }
            
            if let color = color {
                tagToEdit.color = color
            }
        }
        
        save()
        fetchTag()
    }
    
    func deleteTag(tagID: NSManagedObjectID) {
        let context = container.viewContext
        if let tagToDelete = context.object(with: tagID) as? TagEntity {
            context.delete(tagToDelete)
            do {
                try context.save()
                fetchTag() // 목록 업데이트
                print("Tag successfully deleted.")
            } catch {
                print("Error deleting Tag: \(error)")
            }
        }
    }
}
