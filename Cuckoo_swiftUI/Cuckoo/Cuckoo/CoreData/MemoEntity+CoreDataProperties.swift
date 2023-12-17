//
//  MemoEntity+CoreDataProperties.swift
//  
//
//  Created by DKSU on 12/17/23.
//
//

import Foundation
import CoreData


extension MemoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoEntity> {
        return NSFetchRequest<MemoEntity>(entityName: "MemoEntity")
    }

    @NSManaged public var comment: String
    @NSManaged public var created_at: Date?
    @NSManaged public var isPinned: Bool
    @NSManaged public var noti_cycle: Int32
    @NSManaged public var thumbURL: URL?
    @NSManaged public var title: String
    @NSManaged public var updated_at: Date?
    @NSManaged public var url: URL?
    @NSManaged public var noti_count: Int32
    @NSManaged public var memo_log: NSSet?
    @NSManaged public var memo_preset: AlarmPresetEntity?
    @NSManaged public var memo_tag: NSSet?
    @NSManaged public var memo_user: UserEntity?

}

// MARK: Generated accessors for memo_log
extension MemoEntity {

    @objc(addMemo_logObject:)
    @NSManaged public func addToMemo_log(_ value: NotiLogEntity)

    @objc(removeMemo_logObject:)
    @NSManaged public func removeFromMemo_log(_ value: NotiLogEntity)

    @objc(addMemo_log:)
    @NSManaged public func addToMemo_log(_ values: NSSet)

    @objc(removeMemo_log:)
    @NSManaged public func removeFromMemo_log(_ values: NSSet)

}

// MARK: Generated accessors for memo_tag
extension MemoEntity {

    @objc(addMemo_tagObject:)
    @NSManaged public func addToMemo_tag(_ value: TagEntity)

    @objc(removeMemo_tagObject:)
    @NSManaged public func removeFromMemo_tag(_ value: TagEntity)

    @objc(addMemo_tag:)
    @NSManaged public func addToMemo_tag(_ values: NSSet)

    @objc(removeMemo_tag:)
    @NSManaged public func removeFromMemo_tag(_ values: NSSet)

}
