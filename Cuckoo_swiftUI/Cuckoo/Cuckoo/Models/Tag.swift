//
//  TagModel.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//
import SwiftUI
import Foundation

struct Tag:Identifiable{
    var id: Int
    var name: String
    var color: String
    var memoCount: Int
}

// Codable

struct CreateTagRequest: Codable {
    let type, identifier, name, color: String
}

struct LoadTagResponseElement: Codable {
    let id: Int
    let name, color: String
    let memoCount: Int
}

typealias LoadTagResponse = [LoadTagResponseElement]
