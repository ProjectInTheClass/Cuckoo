//
//  UserEntity+CoreDataProperties.swift
//  
//
//  Created by DKSU on 12/14/23.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var created_at: Date?
    @NSManaged public var username: String?
    @NSManaged public var user_memo: NSSet?
    @NSManaged public var user_tag: NSSet?

}

// MARK: Generated accessors for user_memo
extension UserEntity {

    @objc(addUser_memoObject:)
    @NSManaged public func addToUser_memo(_ value: MemoEntity)

    @objc(removeUser_memoObject:)
    @NSManaged public func removeFromUser_memo(_ value: MemoEntity)

    @objc(addUser_memo:)
    @NSManaged public func addToUser_memo(_ values: NSSet)

    @objc(removeUser_memo:)
    @NSManaged public func removeFromUser_memo(_ values: NSSet)

}

// MARK: Generated accessors for user_tag
extension UserEntity {

    @objc(addUser_tagObject:)
    @NSManaged public func addToUser_tag(_ value: TagEntity)

    @objc(removeUser_tagObject:)
    @NSManaged public func removeFromUser_tag(_ value: TagEntity)

    @objc(addUser_tag:)
    @NSManaged public func addToUser_tag(_ values: NSSet)

    @objc(removeUser_tag:)
    @NSManaged public func removeFromUser_tag(_ values: NSSet)

}
