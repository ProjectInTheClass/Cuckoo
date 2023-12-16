//
//  AlarmPresetEntity+CoreDataProperties.swift
//  
//
//  Created by DKSU on 12/17/23.
//
//

import Foundation
import CoreData


extension AlarmPresetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlarmPresetEntity> {
        return NSFetchRequest<AlarmPresetEntity>(entityName: "AlarmPresetEntity")
    }

    @NSManaged public var alarm_time: String?
    @NSManaged public var created_at: Date?
    @NSManaged public var icon: String?
    @NSManaged public var name: String?
    @NSManaged public var updated_at: Date?
    @NSManaged public var preset_memo: NSSet?

}

// MARK: Generated accessors for preset_memo
extension AlarmPresetEntity {

    @objc(addPreset_memoObject:)
    @NSManaged public func addToPreset_memo(_ value: MemoEntity)

    @objc(removePreset_memoObject:)
    @NSManaged public func removeFromPreset_memo(_ value: MemoEntity)

    @objc(addPreset_memo:)
    @NSManaged public func addToPreset_memo(_ values: NSSet)

    @objc(removePreset_memo:)
    @NSManaged public func removeFromPreset_memo(_ values: NSSet)

}
