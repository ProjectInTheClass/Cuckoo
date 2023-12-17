//
//  NotiLogEntity+CoreDataProperties.swift
//  
//
//  Created by DKSU on 12/17/23.
//
//

import Foundation
import CoreData


extension NotiLogEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotiLogEntity> {
        return NSFetchRequest<NotiLogEntity>(entityName: "NotiLogEntity")
    }

    @NSManaged public var related_memo: UUID?
    @NSManaged public var related_preset: String?
    @NSManaged public var sent_at: Date?
    @NSManaged public var log_memo: NSOrderedSet?
    @NSManaged public var log_preset: AlarmPresetEntity?

}

// MARK: Generated accessors for log_memo
extension NotiLogEntity {

    @objc(insertObject:inLog_memoAtIndex:)
    @NSManaged public func insertIntoLog_memo(_ value: MemoEntity, at idx: Int)

    @objc(removeObjectFromLog_memoAtIndex:)
    @NSManaged public func removeFromLog_memo(at idx: Int)

    @objc(insertLog_memo:atIndexes:)
    @NSManaged public func insertIntoLog_memo(_ values: [MemoEntity], at indexes: NSIndexSet)

    @objc(removeLog_memoAtIndexes:)
    @NSManaged public func removeFromLog_memo(at indexes: NSIndexSet)

    @objc(replaceObjectInLog_memoAtIndex:withObject:)
    @NSManaged public func replaceLog_memo(at idx: Int, with value: MemoEntity)

    @objc(replaceLog_memoAtIndexes:withLog_memo:)
    @NSManaged public func replaceLog_memo(at indexes: NSIndexSet, with values: [MemoEntity])

    @objc(addLog_memoObject:)
    @NSManaged public func addToLog_memo(_ value: MemoEntity)

    @objc(removeLog_memoObject:)
    @NSManaged public func removeFromLog_memo(_ value: MemoEntity)

    @objc(addLog_memo:)
    @NSManaged public func addToLog_memo(_ values: NSOrderedSet)

    @objc(removeLog_memo:)
    @NSManaged public func removeFromLog_memo(_ values: NSOrderedSet)

}
