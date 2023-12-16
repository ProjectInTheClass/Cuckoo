//
//  TagEntity+CoreDataProperties.swift
//  
//
//  Created by DKSU on 12/17/23.
//
//

import Foundation
import CoreData


extension TagEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TagEntity> {
        return NSFetchRequest<TagEntity>(entityName: "TagEntity")
    }

    @NSManaged public var color: String
    @NSManaged public var name: String
    @NSManaged public var tag_memo: NSSet?
    @NSManaged public var tag_user: UserEntity?

}

// MARK: Generated accessors for tag_memo
extension TagEntity {

    @objc(addTag_memoObject:)
    @NSManaged public func addToTag_memo(_ value: MemoEntity)

    @objc(removeTag_memoObject:)
    @NSManaged public func removeFromTag_memo(_ value: MemoEntity)

    @objc(addTag_memo:)
    @NSManaged public func addToTag_memo(_ values: NSSet)

    @objc(removeTag_memo:)
    @NSManaged public func removeFromTag_memo(_ values: NSSet)

}
